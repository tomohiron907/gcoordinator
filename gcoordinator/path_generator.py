import numpy as np
from gcoordinator.print_settings import *
from gcoordinator.extrusion_calculator import extrusion_calculator

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
        self.coords = np.column_stack((self.x, self.y, self.z))
        self.start_coord = self.coords[0]
        self.end_coord = self.coords[-1]

        # apply default settings to the object
        self.apply_default_settings()
        # apply optional settings to the object
        self.optional_settings = kwargs
        self.apply_optional_settings()

        #self.extrusion = extrusion_calculator(self.coords)
        self.extrusion = extrusion_calculator(self)

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
        for key, value in self.optional_settings.items():
            setattr(self, key, value)



class PathList:
    def __init__(self, paths):
        self.paths                  = paths

        self._nozzle_diameter       = NOZZLE_DIAMETER
        self._filament_diameter     = FILAMENT_DIAMETER
        self._layer_height          = LAYER_HEIGHT
        self._print_speed           = PRINT_SPEED
        self._travel_speed          = TRAVEL_SPEED
        self._x_origin              = X_ORIGIN
        self._y_origin              = Y_ORIGIN
        self._fan_speed             = FAN_SPEED
        self._nozzle_temperature    = NOZZLE_TEMPERATURE
        self._bed_temperature       = BED_TEMPERATURE
        self._retraction            = RETRACTION
        self._retraction_distance   = RETRACTION_DISTANCE
        self._unretraction_distance = UNRETRACTION_DISTANCE
        self._z_hop                 = Z_HOP
        self._z_hop_distance        = Z_HOP_DISTANCE
        self._extrusion_multiplier  = EXTRUSION_MULTIPLIER
        self._before_gcode          = None
        self._after_gcode           = None


        if len(paths) != 0:
            self.sort_paths()

    @property
    def nozzle_diameter(self):
        return self._nozzle_diameter
    @nozzle_diameter.setter
    def nozzle_diameter(self, value):
        self._nozzle_diameter = value
        self._apply_print_settings()
    
    @property
    def filament_diameter(self):
        return self._filament_diameter
    @filament_diameter.setter
    def filament_diameter(self, value):
        self._filament_diameter = value
        self._apply_print_settings()

    
    @property
    def layer_height(self):
        return self._layer_height
    @layer_height.setter
    def layer_height(self, value):
        self._layer_height = value
        self._apply_print_settings()


    @property
    def print_speed(self):
        return self._print_speed
    @print_speed.setter
    def print_speed(self, value):
        self._print_speed = value
        self._apply_print_settings()


    @property
    def travel_speed(self):
        return self._travel_speed
    @travel_speed.setter
    def travel_speed(self, value):
        self._travel_speed = value
        self._apply_print_settings()
    

    @property
    def x_origin(self):
        return self._x_origin
    @x_origin.setter
    def x_origin(self, value):
        self._x_origin = value
        self._apply_print_settings()
    

    @property
    def y_origin(self):
        return self._y_origin
    @y_origin.setter
    def y_origin(self, value):
        self._y_origin = value
        self._apply_print_settings()
    

    @property
    def fan_speed(self):
        return self._fan_speed
    @fan_speed.setter
    def fan_speed(self, value):
        self._fan_speed = value
        self._apply_print_settings()
    

    @property
    def nozzle_temperature(self):
        return self._nozzle_temperature
    @nozzle_temperature.setter
    def nozzle_temperature(self, value):
        self._nozzle_temperature = value
        self._apply_print_settings()
    

    @property
    def bed_temperature(self):
        return self._bed_temperature
    @bed_temperature.setter
    def bed_temperature(self, value):
        self._bed_temperature = value
        self._apply_print_settings()


    @property
    def retraction(self):
        return self._retraction
    @retraction.setter
    def retraction(self, value):
        self._retraction = value
        self._apply_print_settings()


    @property
    def retraction_distance(self):
        return self._retraction_distance
    @retraction_distance.setter
    def retraction_distance(self, value):
        self._retraction_distance = value
        self._apply_print_settings()
    

    @property
    def unretraction_distance(self):
        return self._unretraction_distance
    @unretraction_distance.setter
    def unretraction_distance(self, value):
        self._unretraction_distance = value
        self._apply_print_settings()
    

    @property
    def z_hop(self):
        return self._z_hop
    @z_hop.setter
    def z_hop(self, value):
        self._z_hop = value
        self._apply_print_settings()
    
    
    @property
    def z_hop_distance(self):
        return self._z_hop_distance
    @z_hop_distance.setter
    def z_hop_distance(self, value):
        self._z_hop_distance = value
        self._apply_print_settings()


    @property
    def extrusion_multiplier(self):
        return self._extrusion_multiplier
    @extrusion_multiplier.setter
    def extrusion_multiplier(self, value):
        self._extrusion_multiplier = value
        self._apply_print_settings()


    @property
    def before_gcode(self):
        return self._before_gcode
    @before_gcode.setter
    def before_gcode(self, value):
        self._before_gcode = value
        self._apply_print_settings()


    @property
    def after_gcode(self):
        return self._after_gcode
    @after_gcode.setter
    def after_gcode(self, value):
        self._after_gcode = value
        self._apply_print_settings()


    def _apply_print_settings(self):
        for path in self.paths:
            path.extrusion_multiplier = self.extrusion_multiplier
            path.print_speed          = self.print_speed
            path.retraction           = self.retraction
            path.z_hop                = self.z_hop
            path.before_gcode         = self.before_gcode
            path.after_gcode          = self.after_gcode

    def sort_paths(self):
        """
        Path sorting algorithm

        Sorts the paths in the PathList object in order of proximity to the previous path's end point.
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