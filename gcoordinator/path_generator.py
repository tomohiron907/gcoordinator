import numpy as np
from gcoordinator.print_settings import *
from gcoordinator.extrusion_calculator import extrusion_calculator

class Path:
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

        self.extrusion = extrusion_calculator(self.coords)

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

        

