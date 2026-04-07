"""
This module provides functions for generating infill paths for 3D printing.
Functions:
- gyroid_infill: Generates a gyroid infill pattern for a given path or path list.
- line_infill: Generates a line infill pattern for a given path or path list.


"""

import numpy as np
from contourpy import contour_generator
from gcoordinator.path_generator import Path, PathList


def _points_in_polygon(polygon_xy: np.ndarray, points: np.ndarray) -> np.ndarray:
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


def gyroid_infill(path, infill_distance=1, value=0):
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
    if isinstance(path, Path):
        path_list = PathList([path])
    elif isinstance(path, PathList):
        path_list = path
    else:
        raise TypeError("path must be a Path or PathList object")

    # Set initial values
    min_x = float('inf')
    max_x = float('-inf')
    min_y = float('inf')
    max_y = float('-inf')

    # Examine the coordinate sequence of each path object and
    #  update the minimum and maximum values
    for path in path_list.paths:
        x_coords = path.x
        y_coords = path.y
        if len(x_coords)>0:
            min_x = min(min_x, min(x_coords))
            max_x = max(max_x, max(x_coords))
            resolution_x = int((max_x-min_x)/0.4)
        if len(y_coords)>0:
            min_y = min(min_y, min(y_coords))
            max_y = max(max_y, max(y_coords))
            resolution_y = int((max_y - min_y)/0.4)
    z_height = path_list.paths[0].center[2]

    # Grid parameters
    # Resolution of the grid
    x = np.linspace(min_x, max_x, resolution_x)
    y = np.linspace(min_y, max_y, resolution_y)
    X, Y = np.meshgrid(x, y)

    # Equation for the Gyroid surface
    theta = np.pi/4
    p = np.pi*np.cos(theta)*np.sqrt(2)/infill_distance # Period of the gyroid surface
    equation = np.sin((X *np.cos(theta) + Y *np.sin(theta))*p) * np.cos((-X *np.sin(theta) + Y *np.cos(theta))*p) \
                + np.sin((-X *np.sin(theta) + Y *np.cos(theta))*p) * np.cos(z_height*p ) \
                + np.sin(z_height*p ) * np.cos((X *np.cos(theta) + Y *np.sin(theta))*p)\
                -value

    insides = []
    for path in path_list.paths:
        x_list = path.x
        y_list = path.y

        # Determine the inside region
        polygon_xy = np.column_stack([x_list, y_list])
        points = np.column_stack((X.flatten(), Y.flatten()))
        inside = _points_in_polygon(polygon_xy, points)
        inside = inside.reshape(X.shape).astype(float)
        inside[inside == 1] = -1 # change inside to -1
        inside[inside == 0] = 1  # Change outside  to 1
        insides.append(inside)

    result = insides[0]  # Set the first ndarray as the initial value

    for i in range(1, len(insides)):
        result = np.multiply(result, insides[i])  # Calculate the Adamar product

    # Replace -1 with np.nan
    result[result == 1] = np.nan

    # Extract contour lines at level 0
    slice_plane = equation * result
    gen = contour_generator(x=x, y=y, z=slice_plane)

    infill_path_list = []
    for vertices in gen.lines(0.0):
        x_coords = vertices[:, 0]
        y_coords = vertices[:, 1]
        z_coords = np.full_like(x_coords, z_height)
        wall = Path(x_coords, y_coords, z_coords)
        infill_path_list.append(wall)

    return PathList(infill_path_list)


def line_infill(path, infill_distance=1, angle=np.pi/4):
    """
    Generates a line infill pattern for a given path.

    Args:
        path (Path or PathList): The path to generate the infill pattern for.
        infill_distance (float, optional): The distance between the lines in the infill pattern. Defaults to 1.
        angle (float, optional): The angle of the infill pattern in radians. Defaults to np.pi/4.

    Returns:
        PathList: A PathList object containing the infill pattern.

    Raises:
        TypeError: If the path argument is not a Path or PathList object.

    """
    if isinstance(path, Path):
        path_list = PathList([path])
    elif isinstance(path, PathList):
        path_list = path
    else:
        raise TypeError("path must be a Path or PathList object")


    x_coords = np.concatenate([path.x for path in path_list.paths if len(path.x) > 0])
    y_coords = np.concatenate([path.y for path in path_list.paths if len(path.y) > 0])
    min_x = np.min(x_coords) if len(x_coords) > 0 else float('inf')
    max_x = np.max(x_coords) if len(x_coords) > 0 else float('-inf')
    min_y = np.min(y_coords) if len(y_coords) > 0 else float('inf')
    max_y = np.max(y_coords) if len(y_coords) > 0 else float('-inf')

    
    z_height = path_list.paths[0].center[2]
    # Grid parameters
    # Resolution of the grid
    x = np.linspace(min_x, max_x, 250)
    y = np.linspace(min_y, max_y, 250)
    X, Y = np.meshgrid(x, y)

    # Equation for the Gyroid surface
    equation = np.sin((X*np.tan(angle) - Y)*np.pi*np.cos(angle)/infill_distance)
    
    insides = []
    for path in path_list.paths:
        x_list = path.x
        y_list = path.y        
        # Determine the inside region
        polygon_xy = np.column_stack([x_list, y_list])
        points = np.column_stack((X.flatten(), Y.flatten()))
        inside = _points_in_polygon(polygon_xy, points)
        inside = inside.reshape(X.shape).astype(float)
        inside[inside == 1] = -1 # change inside to -1
        inside[inside == 0] = 1  # Change outside  to 1
        insides.append(inside)

    result = insides[0]

    for i in range(1, len(insides)):
        result = np.multiply(result, insides[i])

    # Replace -1 with np.nan
    result[result == 1] = np.nan

    # Extract contour lines at level 0
    slice_plane = equation * result
    gen = contour_generator(x=x, y=y, z=slice_plane)
    infill_path_list = []
    for vertices in gen.lines(0.0):
        x_coords = vertices[:, 0]
        y_coords = vertices[:, 1]
        z_coords = np.full_like(x_coords, z_height)
        wall = Path(x_coords, y_coords, z_coords)
        infill_path_list.append(wall)
    return PathList(infill_path_list)