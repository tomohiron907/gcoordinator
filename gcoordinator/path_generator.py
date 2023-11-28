import os
import pickle
import json
from typing import Any
import numpy as np
from gcoordinator.kinematics.kin_bed_rotate  import BedRotate
from gcoordinator.kinematics.kin_cartesian   import Cartesian
from gcoordinator.kinematics.kin_bed_tilt_bc import BedTiltBC
from gcoordinator.kinematics.kin_nozzle_tilt import NozzleTilt
from gcoordinator.settings                   import template_settings


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
    rot : numpy.ndarray
        The rotation at each point in the path, in radians.
    tilt : numpy.ndarray
        The tilt at each point in the path, in radians.
    kinematics : str
        The kinematics of the printer. One of 'Cartesian', 'BedRotate', 'BedTiltBC', or 'NozzleTilt'.
    
    coords : numpy.ndarray
        A 2D array of shape (n_points, 3) containing the (x, y, z) coordinates of the path points.
    norms : numpy.ndarray
        A 2D array of shape (n_points, 3) containing the (x, y, z) components of the normals at each point in the path.
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
    def __init__(self, x, y, z, rot=None, tilt=None, **kwargs):
        try:
            self.settings_path = '.temp_config.json'
            with open(self.settings_path, 'r') as f:
                self.settings = json.load(f)
        except:
            self.settings = template_settings # gcoordinator/settings.py
        
        self.kinematics = self.settings['Hardware']['kinematics']
        self.x = np.array(x)
        self.y = np.array(y)
        self.z = np.array(z)

        if tilt is None:
            self.tilt = np.full_like(x, 0)
        else:
            self.tilt = np.array(tilt)
        if rot is None:
            self.rot  = np.full_like(x, 0)
        else:
            self.rot  = np.array(rot)
            
        self.coords = np.column_stack([self.x, self.y, self.z])
        self.norms = np.array([(0, 0, 1) for _ in range(len(self.coords))])
        self.center = np.array([np.mean(self.x), np.mean(self.y), np.mean(self.z)])
        self.start_coord = self.coords[0]
        self.end_coord = self.coords[-1]
        self.before_gcode = None
        self.after_gcode = None

        # recalculate the coordinates and the norms according to the kinematics
        if self.kinematics == 'Cartesian':
            Cartesian.update_attrs(self)
        elif self.kinematics == 'BedRotate':
            BedRotate.update_attrs(self)
        elif self.kinematics == 'BedTiltBC':
            BedTiltBC.update_attrs(self)
        elif self.kinematics == 'NozzleTilt':
            NozzleTilt.update_attrs(self)
        # apply default settings to the object
        self.apply_default_settings()
        # apply optional settings to the object
        self.optional_settings = kwargs
        self.apply_optional_settings()

    def apply_default_settings(self):
        # When generating G-code, if the attribute of Path is None, 
        # the default value will be used. 
        # During the instantiation of the Path object, the default value is unknown, 
        # so it is set to None.
        self.nozzle_diameter       = None
        self.filament_diameter     = None
        self.layer_height          = None
        self.print_speed           = None
        self.travel_speed          = None
        self.x_origin              = None
        self.y_origin              = None
        self.fan_speed             = None
        self.nozzle_temperature    = None
        self.bed_temperature       = None
        self.retraction            = None
        self.retraction_distance   = None
        self.unretraction_distance = None
        self.z_hop                 = None
        self.z_hop_distance        = None
        self.extrusion_multiplier  = None

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