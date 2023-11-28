import json

def get_default_settings(settings):
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
    """
    Loads the settings from a JSON config file.
    The format of the JSON file is as follows:
    https://gcoordinator.readthedocs.io/en/latest/tutorials/tutorial_4.html

    Args:
        config_path (str): The path to the JSON config file.

    Returns:
        None

    Raises:
        json.JSONDecodeError: If the config file has an invalid JSON format.

    """
    try:
        with open(config_path, 'r') as config_file:
            settings_dict = json.load(config_file)
        settings_name = '.temp_config.json'
        with open(settings_name, 'w') as temp_config:
            json.dump(settings_dict, temp_config, indent=4)

    except json.JSONDecodeError:
        print("Error: Invalid JSON format in the config file. Using default settings.")
    



template_settings = {
    "Print": {
        "nozzle": {
            "nozzle_diameter": 0.4,
            "filament_diameter": 1.75
        },
        "layer": {
            "layer_height": 0.2
        },
        "speed": {
            "print_speed": 5000,
            "travel_speed": 10000
        },
        "origin": {
            "x": 100,
            "y": 100
        },
        "fan_speed": {
            "fan_speed": 255
        },
        "temperature": {
            "nozzle_temperature": 200,
            "bed_temperature": 50
        },
        "travel_option": {
            "retraction": False,
            "retraction_distance": 2.0,
            "unretraction_distance": 2.0,
            "z_hop": False,
            "z_hop_distance": 3
        },
        "extrusion_option": {
            "extrusion_multiplier": 1.0
        }
    },
    "Hardware": {
        "kinematics": "Cartesian",
        "bed_size": {
            "bed_size_x": 200,
            "bed_size_y": 200,
            "bed_size_z": 205
        }
    },
    "Kinematics": {
        "NozzleTilt": {
            "tilt_code": "B",
            "rot_code": "A",
            "tilt_offset": 0.0,
            "rot_offset": 0
        },
        "BedTiltBC": {
            "tilt_code": "B",
            "rot_code": "C",
            "tilt_offset": 0.0,
            "rot_offset": 0,
            "div_distance": 0.5
        },
        "BedRotate": {
            "rot_code": "C",
            "rot_offset": 0.0,
            "div_distance": 0.5
        }
    }
}
