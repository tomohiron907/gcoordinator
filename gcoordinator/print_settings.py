"""
This module loads the default settings for a 3D printer from a JSON file and defines constants for each setting.

The JSON file must be named 'default_settings.json' and located in the same directory as this module.

The following constants are defined:
- NOZZLE_DIAMETER      : the diameter of the printer's nozzle in millimeters
- LAYER_HEIGHT         : the height of each printed layer in millimeters
- FILAMENT_DIAMETER    : the diameter of the filament used by the printer in millimeters
- PRINT_SPEED          : the speed at which the printer extrudes filament during printing in millimeters per minute
- TRAVEL_SPEED         : the speed at which the printer moves between printing locations in millimeters per minute
- X_ORIGIN             : the X coordinate of the printer's origin in millimeters
- Y_ORIGIN             : the Y coordinate of the printer's origin in millimeters
- FAN_SPEED            : the speed of the printer's fan in percent of maximum speed
- NOZZLE_TEMPERATURE   : the temperature of the printer's nozzle in degrees Celsius
- BED_TEMPERATURE      : the temperature of the printer's bed in degrees Celsius
- RETRACTION           : a boolean indicating whether the printer should retract filament during travel moves
- RETRACTION_DISTANCE  : the distance by which the printer should retract filament during travel moves in millimeters
- UNRETRACTION_DISTANCE: the distance by which the printer should unretract filament after travel moves in millimeters
- Z_HOP                : a boolean indicating whether the printer should raise the nozzle during travel moves
- Z_HOP_DISTANCE       : the height by which the printer should raise the nozzle during travel moves in millimeters
- EXTRUSION_MULTIPLIER : a scaling factor for the amount of filament extruded by the printer

"""


import os
import json

# get the path of the default_settings.json file
file_path = os.path.join(os.path.dirname(__file__), 'default_settings.json')

# load the settings from the json file
with open(file_path, 'r') as file:
    settings = json.load(file)

NOZZLE_DIAMETER       = settings['nozzle']['nozzle_diameter']
LAYER_HEIGHT          = settings['layer']['layer_height']
FILAMENT_DIAMETER     = settings['nozzle']['filament_diameter']
PRINT_SPEED           = settings['speed']['print_speed']
TRAVEL_SPEED          = settings['speed']['travel_speed']
X_ORIGIN              = settings['origin']['x']
Y_ORIGIN              = settings['origin']['y']
FAN_SPEED             = settings['fan_speed']['fan_speed']
NOZZLE_TEMPERATURE    = settings['temperature']['nozzle_temperature']
BED_TEMPERATURE       = settings['temperature']['bed_temperature']
RETRACTION            = settings['travel_option']['retraction']
RETRACTION_DISTANCE   = settings['travel_option']['retraction_distance']
UNRETRACTION_DISTANCE = settings['travel_option']['unretraction_distance']
Z_HOP                 = settings['travel_option']['z_hop']
Z_HOP_DISTANCE        = settings['travel_option']['z_hop_distance']
EXTRUSION_MULTIPLIER  = settings['extrusion_option']['extrusion_multiplier']

