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

