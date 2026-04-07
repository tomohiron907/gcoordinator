"""
This module provides functions for generating infill paths for 3D printing.
BUT, the algorithm is not optimized yet. It takes a long time to generate infill paths and file size is large.
so, I am planning to make a new algorithm for infill generation.

Functions:
- gyroid_infill: Generates a gyroid infill pattern for a given path or path list.
- line_infill: Generates a line infill pattern for a given path or path list.
"""

import numpy as np
from contourpy import contour_generator
from gcoordinator.path_generator import Path, PathList


# ── low-level helpers ──────────────────────────────────────────────────────────

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


# ── base class ─────────────────────────────────────────────────────────────────

class _InfillGenerator:
    """
    Base class that implements the shared infill pipeline via the template method pattern.

    Subclasses must implement :meth:`_equation`.
    They may also override :meth:`_resolution` to change grid density.

    Pipeline (executed by ``__call__``):
        1. Normalize input to PathList
        2. Compute bounding box and build the sampling grid
        3. Evaluate the infill equation on the grid
        4. Build the inside/outside mask from the boundary polygons
        5. Extract iso-contour lines at level 0 and convert them to Paths
    """

    def __call__(self, path) -> PathList:
        path_list = self._to_path_list(path)
        x, y, X, Y, z_height = self._build_grid(path_list)
        equation = self._equation(X, Y, z_height)
        mask = self._build_mask(path_list, X, Y)
        return self._contour_to_paths(x, y, equation * mask, z_height)

    # ── override points ────────────────────────────────────────────────────────

    def _equation(self, X: np.ndarray, Y: np.ndarray, z_height: float) -> np.ndarray:
        """Return the scalar field evaluated on the meshgrid. Must be overridden."""
        raise NotImplementedError

    def _resolution(self, min_x: float, max_x: float, min_y: float, max_y: float):
        """Return (res_x, res_y) grid resolution. Default: adaptive 0.4 mm step."""
        return int((max_x - min_x) / 0.4), int((max_y - min_y) / 0.4)

    # ── shared pipeline steps ──────────────────────────────────────────────────

    @staticmethod
    def _to_path_list(path) -> PathList:
        if isinstance(path, Path):
            return PathList([path])
        if isinstance(path, PathList):
            return path
        raise TypeError("path must be a Path or PathList object")

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
        """
        Build a combined inside/outside mask from all boundary polygons.

        Inside cells → -1, outside cells → NaN (via Hadamard product).
        """
        points = np.column_stack((X.ravel(), Y.ravel()))
        result = None
        for p in path_list.paths:
            polygon = np.column_stack([p.x, p.y])
            inside = _points_in_polygon(polygon, points).reshape(X.shape).astype(float)
            inside[inside == 1] = -1  # inside  → -1
            inside[inside == 0] = 1   # outside →  1
            result = inside if result is None else result * inside
        result[result == 1] = np.nan
        return result

    @staticmethod
    def _contour_to_paths(x: np.ndarray, y: np.ndarray, z: np.ndarray, z_height: float) -> PathList:
        """Extract iso-contour lines at level 0 and return them as a PathList."""
        gen = contour_generator(x=x, y=y, z=z)
        paths = []
        for vertices in gen.lines(0.0):
            x_c = vertices[:, 0]
            y_c = vertices[:, 1]
            z_c = np.full_like(x_c, z_height)
            paths.append(Path(x_c, y_c, z_c))
        return PathList(paths)


# ── concrete generators ────────────────────────────────────────────────────────

class _GyroidInfillGenerator(_InfillGenerator):
    def __init__(self, infill_distance: float, value: float):
        self.infill_distance = infill_distance
        self.value = value

    def _equation(self, X: np.ndarray, Y: np.ndarray, z_height: float) -> np.ndarray:
        theta = np.pi / 4
        p = np.pi * np.cos(theta) * np.sqrt(2) / self.infill_distance
        rot_x =  X * np.cos(theta) + Y * np.sin(theta)
        rot_y = -X * np.sin(theta) + Y * np.cos(theta)
        return (
            np.sin(rot_x * p) * np.cos(rot_y * p)
            + np.sin(rot_y * p) * np.cos(z_height * p)
            + np.sin(z_height * p) * np.cos(rot_x * p)
            - self.value
        )


class _LineInfillGenerator(_InfillGenerator):
    def __init__(self, infill_distance: float, angle: float):
        self.infill_distance = infill_distance
        self.angle = angle

    def _resolution(self, min_x, max_x, min_y, max_y):
        return 250, 250

    def _equation(self, X: np.ndarray, Y: np.ndarray, z_height: float) -> np.ndarray:
        return np.sin((X * np.tan(self.angle) - Y) * np.pi * np.cos(self.angle) / self.infill_distance)


# ── public API ─────────────────────────────────────────────────────────────────

def gyroid_infill(path, infill_distance=1, value=0) -> PathList:
    """
    Generates a gyroid infill pattern for a given path.

    Args:
        path (Path or PathList): The path to generate the infill pattern for.
        infill_distance (float): The distance between the gyroid surfaces.
        value (float): The value to subtract from the gyroid equation.

    Returns:
        PathList: A PathList object containing the generated infill pattern.

    Raises:
        TypeError: If path is not a Path or PathList object.
    """
    return _GyroidInfillGenerator(infill_distance, value)(path)


def line_infill(path, infill_distance=1, angle=np.pi/4) -> PathList:
    """
    Generates a line infill pattern for a given path.

    Args:
        path (Path or PathList): The path to generate the infill pattern for.
        infill_distance (float): The distance between the lines. Defaults to 1.
        angle (float): The angle of the infill pattern in radians. Defaults to pi/4.

    Returns:
        PathList: A PathList object containing the infill pattern.

    Raises:
        TypeError: If path is not a Path or PathList object.
    """
    return _LineInfillGenerator(infill_distance, angle)(path)
