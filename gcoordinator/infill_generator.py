"""
This module provides functions for generating infill paths for 3D printing.


Infill patterns fall into two categories with different generation strategies:

  Category 1 – Implicit surface (TPMS):
    gyroid_infill, schwartz_p_infill
    Defined by a 3D equation f(X, Y, Z) = 0. The layer cross-section is obtained
    by extracting iso-contour lines of f sampled on the print-plane grid.

  Category 2 – Line pattern:
    line_infill, grid_infill, triangle_infill
    Defined as families of parallel straight lines. Each line is clipped against
    the boundary polygon using a scanline algorithm, guaranteeing that every
    returned Path is a true straight segment.
"""

import numpy as np
from contourpy import contour_generator
from gcoordinator.path_generator import Path, PathList


# ─────────────────────────────────────────────────────────────────────────────
# Shared helper
# ─────────────────────────────────────────────────────────────────────────────

def _points_in_polygon(polygon_xy: np.ndarray, points: np.ndarray) -> np.ndarray:
    """Vectorized even-odd ray-casting point-in-polygon test."""
    px, py = points[:, 0], points[:, 1]
    vx, vy = polygon_xy[:, 0], polygon_xy[:, 1]
    vx_next = np.roll(vx, -1)
    vy_next = np.roll(vy, -1)

    py_col      = py[:, np.newaxis]
    px_col      = px[:, np.newaxis]
    vy_row      = vy[np.newaxis, :]
    vy_next_row = vy_next[np.newaxis, :]
    vx_row      = vx[np.newaxis, :]
    vx_next_row = vx_next[np.newaxis, :]

    cond = (vy_row > py_col) != (vy_next_row > py_col)
    with np.errstate(divide='ignore', invalid='ignore'):
        x_intersect = vx_row + (py_col - vy_row) * (vx_next_row - vx_row) / (vy_next_row - vy_row)
    crosses = cond & (px_col < x_intersect)
    return np.count_nonzero(crosses, axis=1) % 2 == 1


# ─────────────────────────────────────────────────────────────────────────────
# Abstract base
# ─────────────────────────────────────────────────────────────────────────────

class _InfillGenerator:
    def __call__(self, path) -> PathList:
        raise NotImplementedError

    @staticmethod
    def _to_path_list(path) -> PathList:
        if isinstance(path, Path):
            return PathList([path])
        if isinstance(path, PathList):
            return path
        raise TypeError("path must be a Path or PathList object")


# ─────────────────────────────────────────────────────────────────────────────
# Category 1: Implicit surface – iso-contour extraction
# ─────────────────────────────────────────────────────────────────────────────

class _ImplicitSurfaceInfillGenerator(_InfillGenerator):
    """
    Generates infill by sampling a scalar field f(X, Y, z_height) on a 2-D grid
    and extracting iso-contour lines at level 0.

    Appropriate for TPMS-like equations whose zero-contour on the print plane
    forms closed or open curves without self-intersections at grid crossings.

    Subclasses must implement _equation().
    """

    def __call__(self, path) -> PathList:
        path_list = self._to_path_list(path)
        x, y, X, Y, z_height = self._build_grid(path_list)
        equation = self._equation(X, Y, z_height)
        mask = self._build_mask(path_list, X, Y)
        return self._contour_to_paths(x, y, equation * mask, z_height)

    def _equation(self, X: np.ndarray, Y: np.ndarray, z_height: float) -> np.ndarray:
        raise NotImplementedError

    def _resolution(self, min_x: float, max_x: float, min_y: float, max_y: float):
        """Grid resolution: default adaptive 0.4 mm step."""
        return int((max_x - min_x) / 0.4), int((max_y - min_y) / 0.4)

    def _build_grid(self, path_list: PathList):
        all_x = np.concatenate([p.x for p in path_list.paths if len(p.x) > 0])
        all_y = np.concatenate([p.y for p in path_list.paths if len(p.y) > 0])
        min_x, max_x = all_x.min(), all_x.max()
        min_y, max_y = all_y.min(), all_y.max()
        res_x, res_y = self._resolution(min_x, max_x, min_y, max_y)
        z_height = path_list.paths[0].center[2]
        x = np.linspace(min_x, max_x, res_x)
        y = np.linspace(min_y, max_y, res_y)
        X, Y = np.meshgrid(x, y)
        return x, y, X, Y, z_height

    @staticmethod
    def _build_mask(path_list: PathList, X: np.ndarray, Y: np.ndarray) -> np.ndarray:
        points = np.column_stack((X.ravel(), Y.ravel()))
        result = None
        for p in path_list.paths:
            polygon = np.column_stack([p.x, p.y])
            inside = _points_in_polygon(polygon, points).reshape(X.shape).astype(float)
            inside[inside == 1] = -1  # inside  → -1
            inside[inside == 0] =  1  # outside →  1
            result = inside if result is None else result * inside
        result[result == 1] = np.nan
        return result

    @staticmethod
    def _contour_to_paths(x, y, z, z_height: float) -> PathList:
        gen = contour_generator(x=x, y=y, z=z)
        paths = []
        for vertices in gen.lines(0.0):
            x_c = vertices[:, 0]
            y_c = vertices[:, 1]
            z_c = np.full_like(x_c, z_height)
            paths.append(Path(x_c, y_c, z_c))
        return PathList(paths)


# ─────────────────────────────────────────────────────────────────────────────
# Category 2: Line pattern – scanline clipping
# ─────────────────────────────────────────────────────────────────────────────

class _LinePatternInfillGenerator(_InfillGenerator):
    """
    Generates infill as one or more families of parallel straight lines,
    each clipped against the boundary polygon.

    Algorithm for each family (angle θ, spacing d):
      1. Rotate all polygon vertices by -θ  →  lines become horizontal.
      2. Generate scanlines at y' = k·d (in rotated frame) within the bbox.
      3. Clip each scanline against the rotated polygon (even-odd rule).
      4. Rotate the segment endpoints back by +θ  →  original frame.

    Every returned Path is guaranteed to be a straight 2-point segment.

    Subclasses must implement _line_families().
    """

    def _line_families(self) -> list[tuple[float, float]]:
        """Return [(angle_rad, spacing), ...] for each family of parallel lines."""
        raise NotImplementedError

    def __call__(self, path) -> PathList:
        path_list = self._to_path_list(path)
        polygons = [np.column_stack([p.x, p.y]) for p in path_list.paths
                    if len(p.x) > 0]
        z_height = float(path_list.paths[0].center[2])

        infill_paths = []
        for angle, spacing in self._line_families():
            cos_a, sin_a = np.cos(angle), np.sin(angle)

            # Rotate each boundary polygon by -angle
            rot_polygons = []
            for poly in polygons:
                rx =  poly[:, 0] * cos_a + poly[:, 1] * sin_a
                ry = -poly[:, 0] * sin_a + poly[:, 1] * cos_a
                rot_polygons.append(np.column_stack([rx, ry]))

            all_ry = np.concatenate([p[:, 1] for p in rot_polygons])
            all_rx = np.concatenate([p[:, 0] for p in rot_polygons])
            min_ry, max_ry = float(all_ry.min()), float(all_ry.max())
            min_rx, max_rx = float(all_rx.min()), float(all_rx.max())

            k0 = int(np.ceil(min_ry / spacing))
            k1 = int(np.floor(max_ry / spacing))
            for k in range(k0, k1 + 1):
                ry_val = k * spacing
                for rx0, rx1 in self._clip_scanline(ry_val, rot_polygons, min_rx, max_rx):
                    # Rotate endpoints back by +angle
                    x0 = rx0 * cos_a - ry_val * sin_a
                    y0 = rx0 * sin_a + ry_val * cos_a
                    x1 = rx1 * cos_a - ry_val * sin_a
                    y1 = rx1 * sin_a + ry_val * cos_a
                    infill_paths.append(Path(
                        np.array([x0, x1]),
                        np.array([y0, y1]),
                        np.array([z_height, z_height]),
                    ))

        return PathList(infill_paths)

    @staticmethod
    def _clip_scanline(y_val: float, polygons: list, lo_x: float, hi_x: float):
        """
        Find (x0, x1) segment pairs where the horizontal line y = y_val is inside
        the boundary (even-odd rule across all polygon edges).
        """
        crossings = []
        for poly in polygons:
            vy     = poly[:, 1]
            vx     = poly[:, 0]
            vy_next = np.roll(vy, -1)
            vx_next = np.roll(vx, -1)
            mask = (vy > y_val) != (vy_next > y_val)
            if mask.any():
                t  = (y_val - vy[mask]) / (vy_next[mask] - vy[mask])
                xi = vx[mask] + t * (vx_next[mask] - vx[mask])
                crossings.extend(xi.tolist())
        crossings.sort()
        segments = []
        for i in range(0, len(crossings) - 1, 2):
            x0 = max(crossings[i],     lo_x)
            x1 = min(crossings[i + 1], hi_x)
            if x0 < x1:
                segments.append((x0, x1))
        return segments


# ─────────────────────────────────────────────────────────────────────────────
# Concrete generators – Category 1 (implicit surface)
# ─────────────────────────────────────────────────────────────────────────────

class _GyroidInfillGenerator(_ImplicitSurfaceInfillGenerator):
    """
    Gyroid TPMS: sin(X'p)cos(Y'p) + sin(Y'p)cos(Zp) + sin(Zp)cos(X'p) = value
    X', Y' are the meshgrid coordinates rotated 45°. Pattern varies with z.
    """
    def __init__(self, infill_distance: float, value: float):
        self.infill_distance = infill_distance
        self.value = value

    def _equation(self, X, Y, z_height):
        theta = np.pi / 4
        p     = np.pi * np.cos(theta) * np.sqrt(2) / self.infill_distance
        rot_x =  X * np.cos(theta) + Y * np.sin(theta)
        rot_y = -X * np.sin(theta) + Y * np.cos(theta)
        return (
            np.sin(rot_x * p) * np.cos(rot_y * p)
            + np.sin(rot_y * p) * np.cos(z_height * p)
            + np.sin(z_height * p) * np.cos(rot_x * p)
            - self.value
        )


class _SchwartzPInfillGenerator(_ImplicitSurfaceInfillGenerator):
    """
    Schwartz P TPMS: cos(Xp) + cos(Yp) + cos(Zp) = value. Pattern varies with z.
    """
    def __init__(self, infill_distance: float, value: float):
        self.infill_distance = infill_distance
        self.value = value

    def _equation(self, X, Y, z_height):
        p = 2 * np.pi / self.infill_distance
        return np.cos(X * p) + np.cos(Y * p) + np.cos(z_height * p) - self.value


# ─────────────────────────────────────────────────────────────────────────────
# Concrete generators – Category 2 (line pattern)
# ─────────────────────────────────────────────────────────────────────────────

class _LineInfillGenerator(_LinePatternInfillGenerator):
    """Single family of parallel lines at a given angle."""
    def __init__(self, infill_distance: float, angle: float):
        self.infill_distance = infill_distance
        self.angle = angle

    def _line_families(self):
        return [(self.angle, self.infill_distance)]


class _GridInfillGenerator(_LinePatternInfillGenerator):
    """Two families of axis-aligned lines (0° and 90°)."""
    def __init__(self, infill_distance: float):
        self.infill_distance = infill_distance

    def _line_families(self):
        d = self.infill_distance
        return [(0.0, d), (np.pi / 2, d)]


class _TriangleInfillGenerator(_LinePatternInfillGenerator):
    """Three families of lines at 0°, 60°, 120° forming an equilateral triangular grid."""
    def __init__(self, infill_distance: float):
        self.infill_distance = infill_distance

    def _line_families(self):
        d = self.infill_distance
        return [(0.0, d), (np.pi / 3, d), (2 * np.pi / 3, d)]


# ─────────────────────────────────────────────────────────────────────────────
# Public API – unified class (gc.Infill.xxx)
# ─────────────────────────────────────────────────────────────────────────────

class Infill:
    """
    Namespace class for infill pattern generation, mirroring the Transform API.

    Usage::

        import gcoordinator as gc
        infill = gc.Infill.gyroid(wall, infill_distance=2)
        infill = gc.Infill.schwartz_p(wall, infill_distance=2)
        infill = gc.Infill.line(wall, infill_distance=2, angle=np.pi/4)
        infill = gc.Infill.grid(wall, infill_distance=2)
        infill = gc.Infill.triangle(wall, infill_distance=2)
    """

    @staticmethod
    def gyroid(path, infill_distance=1, value=0) -> PathList:
        """
        Gyroid (TPMS) infill. Pattern varies with layer height.

        Args:
            path (Path or PathList): Boundary of the infill region.
            infill_distance (float): Spacing between gyroid surfaces.
            value (float): Iso-level offset; 0 gives the mid-surface.

        Returns:
            PathList: Generated infill paths.
        """
        return _GyroidInfillGenerator(infill_distance, value)(path)

    @staticmethod
    def schwartz_p(path, infill_distance=1, value=0) -> PathList:
        """
        Schwartz P (TPMS) infill. Pattern varies with layer height.

        Args:
            path (Path or PathList): Boundary of the infill region.
            infill_distance (float): Spacing between surfaces.
            value (float): Iso-level offset; 0 gives the mid-surface.

        Returns:
            PathList: Generated infill paths.
        """
        return _SchwartzPInfillGenerator(infill_distance, value)(path)

    @staticmethod
    def line(path, infill_distance=1, angle=np.pi/4) -> PathList:
        """
        Parallel-line infill at a given angle.

        Args:
            path (Path or PathList): Boundary of the infill region.
            infill_distance (float): Perpendicular spacing between lines.
            angle (float): Angle of the lines from the X-axis in radians.

        Returns:
            PathList: Generated infill paths (each Path is a straight segment).
        """
        return _LineInfillGenerator(infill_distance, angle)(path)

    @staticmethod
    def grid(path, infill_distance=1) -> PathList:
        """
        Rectilinear grid infill (lines in X and Y).

        Args:
            path (Path or PathList): Boundary of the infill region.
            infill_distance (float): Spacing between grid lines.

        Returns:
            PathList: Generated infill paths (each Path is a straight segment).
        """
        return _GridInfillGenerator(infill_distance)(path)

    @staticmethod
    def triangle(path, infill_distance=1) -> PathList:
        """
        Triangular grid infill (lines at 0°, 60°, 120°).

        Args:
            path (Path or PathList): Boundary of the infill region.
            infill_distance (float): Perpendicular spacing within each line family.

        Returns:
            PathList: Generated infill paths (each Path is a straight segment).
        """
        return _TriangleInfillGenerator(infill_distance)(path)


# ─────────────────────────────────────────────────────────────────────────────
# Backward-compatible module-level aliases
# ─────────────────────────────────────────────────────────────────────────────

def gyroid_infill(path, infill_distance=1, value=0) -> PathList:
    """Backward-compatible alias for Infill.gyroid()."""
    return Infill.gyroid(path, infill_distance, value)


def line_infill(path, infill_distance=1, angle=np.pi/4) -> PathList:
    """Backward-compatible alias for Infill.line()."""
    return Infill.line(path, infill_distance, angle)


