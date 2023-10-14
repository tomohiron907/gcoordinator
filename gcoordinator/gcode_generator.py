import os
import numpy as np
from gcoordinator import print_settings 


class GCode:
    """
    Represents a G-code generator for 3D printing.

    Attributes:
        full_object (list): A list of `Path` objects representing the paths to be printed.
        txt (str): A string containing the G-code instructions for the object.

    Methods:
        __init__(self, full_object:list) -> None: Initializes a new `GCode` object with the given `full_object`.
        generate_gcode(self): Generates G-code instructions for the current object, based on its paths and extrusion values.
        save(self, file_path): Saves the generated G-code to a file.
        start_gcode(self, file_path): Prepends the contents of a file to the current G-code text.
        end_gcode(self, file_path): Appends the contents of the file at the given file path to the current G-code text.

    """

    def __init__(self, full_object: list) -> None:
        # full_object is a list of Path objects
        self.full_object = full_object
        self.txt = self.generate_gcode()

    def generate_gcode(self):
        """
        Generates G-code instructions for the current object, based on its paths and extrusion values.

        Returns:
            str: A string containing the G-code instructions for the object.
        """
        txt = ''
        for path in self.full_object:
            # apply path settings
            txt += self.apply_path_settings(path)
            # travel to the first point of the path
            txt += f'G0 F{path.travel_speed} '
            txt += f'X{path.x[0]+path.x_origin} '
            txt += f'Y{path.y[0]+path.y_origin} '
            txt += f'Z{path.z[0]}\n'
            for i in range(len(path.x)-1):
                # print the path. move to the next point with extrusion
                txt += f'G1 F{path.print_speed} '
                txt += f'X{path.x[i+1]+path.x_origin} '
                txt += f'Y{path.y[i+1]+path.y_origin} '
                txt += f'Z{path.z[i+1]} '
                txt += f'E{path.extrusion[i]}\n'
        return txt
    
    def set_initial_settings(self):
        """
        Generates G-code commands to set the initial printer settings, such as bed and nozzle temperature, extrusion mode,
        and fan speed, based on the values defined in the `print_settings` module.

        Returns:
            str: A string containing the G-code commands to set the initial printer settings.
        """
        txt = ''
        txt += f'M140 S{print_settings.BED_TEMPERATURE} \n'
        txt += f'M190 S{print_settings.BED_TEMPERATURE} \n'
        txt += f'M104 S{print_settings.NOZZLE_TEMPERATURE} \n'
        txt += f'M109 S{print_settings.NOZZLE_TEMPERATURE} \n'
        txt += f'M83 ;relative extrusion mode \n'
        txt += f'M106 S{print_settings.FAN_SPEED} \n'
        return txt
    
    def apply_path_settings(self, path):
        """
        Generate G-code commands to apply the settings of the given `path` object.
        The method returns a string containing the G-code commands that should be
        sent to the printer to apply the settings of the path.
        
        :param path: a `Path` object containing the settings to apply.
        :type path: Path
        :return: a string containing the G-code commands to apply the settings.
        :rtype: str
        """
        txt = ''
        if path.nozzle_temperature != print_settings.NOZZLE_TEMPERATURE:
            txt += f'M104 S{path.nozzle_temperature} \n'
        if path.bed_temperature != print_settings.BED_TEMPERATURE:
            txt += f'M140 S{path.bed_temperature} \n'
        if path.fan_speed != print_settings.FAN_SPEED:
            txt += f'M106 S{path.fan_speed} \n'
        return txt

    def save(self, file_path):
        """
        Saves the generated G-code to a file.

        Reads the contents of the start G-code file, generates the initial settings G-code,
        reads the contents of the end G-code file, combines the start G-code, initial settings G-code,
        object G-code, and end G-code, and writes the combined G-code to the specified file.

        :param file_path: The path of the file to write the G-code to.
        :type file_path: str
        """

        # Read the contents of the start G-code file
        with open(self.start_gcode_path, 'r') as f:
            self.start_gcode_txt = f.read()
        
        # Generate the initial settings G-code
        self.initial_settings_txt = self.set_initial_settings()
        
        # Read the contents of the end G-code file
        with open(self.end_gcode_path, 'r') as f:
            self.end_gcode_txt = f.read()
        
        # Combine the start G-code, initial settings G-code, object G-code, and end G-code
        self.gcode = (
            self.start_gcode_txt
            + self.initial_settings_txt
            + self.txt
            + self.end_gcode_txt
        )
        
        # Write the combined G-code to the specified file
        with open(file_path, 'w') as f:
            f.write(self.gcode)
        

    def start_gcode(self, file_path):
        self.start_gcode_path = file_path
        

    def end_gcode(self, file_path):
        self.end_gcode_path = file_path

