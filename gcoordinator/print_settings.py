import os
import json

def get_default_settings(json_path):
    """
    This function loads the default settings for a 3D printer from a JSON file and retunrs them as a dictionary.

    The following constants are defined:
    - 'nozzle_diameter'      : the diameter of the printer's nozzle in millimeters
    - 'layer_height'         : the height of each printed layer in millimeters
    - 'filament_diameter'    : the diameter of the filament used by the printer in millimeters
    - 'print_speed'          : the speed at which the printer extrudes filament during printing in millimeters per minute
    - 'travel_speed'         : the speed at which the printer moves between printing locations in millimeters per minute
    - 'x_origin'             : the X coordinate of the printer's origin in millimeters
    - 'y_origin'             : the Y coordinate of the printer's origin in millimeters
    - 'fan_speed'            : the speed of the printer's fan in percent of maximum speed
    - 'nozzle_temperature'   : the temperature of the printer's nozzle in degrees Celsius
    - 'bed_temperature'      : the temperature of the printer's bed in degrees Celsius
    - 'retraction'           : a boolean indicating whether the printer should retract filament during travel moves
    - 'retraction_distance'  : the distance by which the printer should retract filament during travel moves in millimeters
    - 'unretraction_distance': the distance by which the printer should unretract filament after travel moves in millimeters
    - 'z_hop'                : a boolean indicating whether the printer should raise the nozzle during travel moves
    - 'z_hop_distance'       : the height by which the printer should raise the nozzle during travel moves in millimeters
    - 'extrusion_multiplier' : a scaling factor for the amount of filament extruded by the printer

    """
    # load the settings from the json file
    with open(json_path, 'r') as file:
        settings = json.load(file)

    default_settings = {
        'nozzle_diameter'      : settings['nozzle']['nozzle_diameter'],
        'layer_height'         : settings['layer']['layer_height'],
        'filament_diameter'    : settings['nozzle']['filament_diameter'],
        'print_speed'          : settings['speed']['print_speed'],
        'travel_speed'         : settings['speed']['travel_speed'],
        'x_origin'             : settings['origin']['x'],
        'y_origin'             : settings['origin']['y'],
        'fan_speed'            : settings['fan_speed']['fan_speed'],
        'nozzle_temperature'   : settings['temperature']['nozzle_temperature'],
        'bed_temperature'      : settings['temperature']['bed_temperature'],
        'retraction'           : settings['travel_option']['retraction'],
        'retraction_distance'  : settings['travel_option']['retraction_distance'],
        'unretraction_distance': settings['travel_option']['unretraction_distance'],
        'z_hop'                : settings['travel_option']['z_hop'],
        'z_hop_distance'       : settings['travel_option']['z_hop_distance'],
        'extrusion_multiplier' : settings['extrusion_option']['extrusion_multiplier']
    }

    return default_settings
