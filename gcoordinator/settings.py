import os
import json
import pickle
def get_default_settings(pickle_path):
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
    with open(pickle_path, 'rb') as f:
        settings = pickle.load(f)

    default_settings = {
        'nozzle_diameter'      : settings['Print']['nozzle']['nozzle_diameter'],
        'layer_height'         : settings['Print']['layer']['layer_height'],
        'filament_diameter'    : settings['Print']['nozzle']['filament_diameter'],
        'print_speed'          : settings['Print']['speed']['print_speed'],
        'travel_speed'         : settings['Print']['speed']['travel_speed'],
        'x_origin'             : settings['Print']['origin']['x'],
        'y_origin'             : settings['Print']['origin']['y'],
        'fan_speed'            : settings['Print']['fan_speed']['fan_speed'],
        'nozzle_temperature'   : settings['Print']['temperature']['nozzle_temperature'],
        'bed_temperature'      : settings['Print']['temperature']['bed_temperature'],
        'retraction'           : settings['Print']['travel_option']['retraction'],
        'retraction_distance'  : settings['Print']['travel_option']['retraction_distance'],
        'unretraction_distance': settings['Print']['travel_option']['unretraction_distance'],
        'z_hop'                : settings['Print']['travel_option']['z_hop'],
        'z_hop_distance'       : settings['Print']['travel_option']['z_hop_distance'],
        'extrusion_multiplier' : settings['Print']['extrusion_option']['extrusion_multiplier']
    }

    return default_settings




def load_settings(config_path):
    # load the default settings from the json file
    # when this function is called, the default settings are saved to a pickle file
    # the pickle file is loaded when the GCode class is instantiated
    # after generating the Gcode, the pickle file is reset to the default settings
    try:
        with open(config_path, 'r') as config_file:
            settings_dict = json.load(config_file)
        # use the settings from the config file if it is valid JSON
        # save the settings to a pickle file
        pickle_path = os.path.join(os.path.dirname(__file__), 'settings/settings.pickle')
        with open(pickle_path, 'wb') as f:
            pickle.dump(settings_dict, f)

    except json.JSONDecodeError:
        # use the default settings if the config file is not valid JSON
        print("Error: Invalid JSON format in the config file. Using default settings.")
    