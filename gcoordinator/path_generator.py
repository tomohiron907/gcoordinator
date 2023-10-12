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

        

