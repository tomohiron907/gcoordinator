from typing import Any
import numpy as np
from gcoordinator.print_settings import *

class Path:
    """
    A class representing a path in 3D space.

    Attributes:
    -----------
    x : numpy.ndarray
        The x-coordinates of the path points.
    y : numpy.ndarray
        The y-coordinates of the path points.
    z : numpy.ndarray
        The z-coordinates of the path points.
    coords : numpy.ndarray
        A 2D array of shape (n_points, 3) containing the (x, y, z) coordinates of the path points.
    center : numpy.ndarray
        The center of the path, calculated as the mean of the path points.
    start_coord : numpy.ndarray
        The coordinates of the first point in the path.
    end_coord : numpy.ndarray
        The coordinates of the last point in the path.
    
    nozzle_diameter : float
        The diameter of the printer nozzle, in millimeters.
    filament_diameter : float
        The diameter of the printer filament, in millimeters.
    layer_height : float
        The height of each printed layer, in millimeters.
    print_speed : float
        The speed at which the printer extrudes filament, in millimeters per second.
    travel_speed : float
        The speed at which the printer moves between points, in millimeters per second.
    x_origin : float
        The x-coordinate of the origin of the printer's coordinate system, in millimeters.
    y_origin : float
        The y-coordinate of the origin of the printer's coordinate system, in millimeters.
    fan_speed : float
        The speed of the printer's cooling fan, as a percentage of its maximum speed.
    nozzle_temperature : float
        The temperature of the printer nozzle, in degrees Celsius.
    bed_temperature : float
        The temperature of the printer bed, in degrees Celsius.
    retraction : bool
        Whether to retract the filament between moves.
    retraction_distance : float
        The distance by which to retract the filament, in millimeters.
    unretraction_distance : float
        The distance by which to unretract the filament, in millimeters.
    z_hop : bool
        Whether to perform a Z-hop between moves.
    z_hop_distance : float
        The distance by which to Z-hop, in millimeters.
    extrusion_multiplier : float
        A multiplier for the amount of filament extruded, used to adjust for filament diameter variations.

    Methods:
    --------
    apply_default_settings()
        Applies the default settings to the object.
    apply_optional_settings()
        Applies the optional settings to the object.
    
    """
    def __init__(self, x, y, z, **kwargs):
        self.x = np.array(x)
        self.y = np.array(y)
        self.z = np.array(z)
        self.coords = np.column_stack([self.x, self.y, self.z])
        self.norms = [(0, 0, 1) for _ in range(len(self.coords))]
        self.center = np.array([np.mean(self.x), np.mean(self.y), np.mean(self.z)])
        self.start_coord = self.coords[0]
        self.end_coord = self.coords[-1]
        self.before_gcode = None
        self.after_gcode = None

        # apply default settings to the object
        self.apply_default_settings()
        # apply optional settings to the object
        self.optional_settings = kwargs
        self.apply_optional_settings()

    def apply_default_settings(self):
        # apply json settings to the object
        # json settings are defined in gcoordinator/print_settings.py 
        self.nozzle_diameter       = NOZZLE_DIAMETER
        self.filament_diameter     = FILAMENT_DIAMETER
        self.layer_height          = LAYER_HEIGHT
        self.print_speed           = PRINT_SPEED
        self.travel_speed          = TRAVEL_SPEED
        self.x_origin              = X_ORIGIN
        self.y_origin              = Y_ORIGIN
        self.fan_speed             = FAN_SPEED
        self.nozzle_temperature    = NOZZLE_TEMPERATURE
        self.bed_temperature       = BED_TEMPERATURE
        self.retraction            = RETRACTION
        self.retraction_distance   = RETRACTION_DISTANCE
        self.unretraction_distance = UNRETRACTION_DISTANCE
        self.z_hop                 = Z_HOP
        self.z_hop_distance        = Z_HOP_DISTANCE
        self.extrusion_multiplier  = EXTRUSION_MULTIPLIER

    def apply_optional_settings(self):
        """
        Applies optional settings to the current instance of the Path class.

        This method iterates over the optional_settings dictionary and sets each key-value pair as an attribute of the
        current instance of the PathGenerator class.

        Args:
            None

        Returns:
            None
        """
        for key, value in self.optional_settings.items():
            setattr(self, key, value)


class PathList:
    """
    A class representing a list of paths. This class has the same attributes of Path class.
    The attributes are applied to all paths in the PathList.

    Attributes:
        paths (list): A list of Path objects.
        all attributes of Path class

    Methods:
        __init__(self, paths): Initializes a PathList object with a list of Path objects.
        __setattr__(self, name, value): Sets an attribute to all paths in the PathList.
        sort_paths(self): Sorts the paths in the PathList object in order of proximity to the previous path's end point.
    """
    def __init__(self, paths):
        self.paths = paths
        self.index = 0 # index for __next__
        if len(paths) != 0:
            self.sort_paths()

    def __setattr__(self, name, value):
        """
        Sets an attribute to all paths in the PathList.

        Args:
            name (str): The name of the attribute to set.
            value (any): The value to set the attribute to.

        Returns:
            None
        """
        if name == 'paths':
            self.__dict__[name] = value
            return
        # set attribute to all paths in the PathList
        for path in self.paths:
            if hasattr(path, name):
                setattr(path, name, value)
            else:
                self.__dict__[name] = value
    
    def __iter__(self):
        return self

    def __next__(self):
        if self.index < len(self.paths):
            current_path = self.paths[self.index]
            self.index += 1
            return current_path
        else:
            raise StopIteration()

    def sort_paths(self):
        """
        Sorts the paths in the PathList object in order of proximity to the previous path's end point.

        Args:
            None

        Returns:
            None
        """
        sorted_paths = []
        remaining_paths = self.paths.copy()

        # Extract first path and add to sorted list
        current_path = remaining_paths.pop(0)
        sorted_paths.append(current_path)

        while remaining_paths:
            nearest_index = None
            min_distance = float('inf')

            # Find the path with the closest starting point among unsorted paths
            for i, path in enumerate(remaining_paths):
                distance = np.linalg.norm(current_path.end_coord - path.start_coord)
                if distance < min_distance:
                    min_distance = distance
                    nearest_index = i

            # Retrieve the closest path and add it to the sorted list
            current_path = remaining_paths.pop(nearest_index)
            sorted_paths.append(current_path)

        self.paths = sorted_paths


def flatten_path_list(full_object):
    """
    the full_object(list) is composed of Path and PathList.
    when calcuate, PathList nedds to be flatten.
    this function makes all elements in full_object to Path.

    args    : list of Path and PathList
    returns : list of Path
    """
    flattened_paths = []
    for item in full_object:
        if isinstance(item, PathList):
            flattened_paths.extend(flatten_path_list(item.paths))
        elif isinstance(item, Path):
            flattened_paths.append(item)
    return flattened_paths