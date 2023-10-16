import os
import numpy as np
from gcoordinator import print_settings 
from gcoordinator.path_generator import flatten_path_list


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
        # full_object is a list of Path or PathList objects
        # flatten_path_list() flattens the list of PathList objects into a list of Path objects
        self.full_object = flatten_path_list(full_object) # list of Path objects
        self.gcode = None              # gcode file object

    def save(self, file_path):
        """
        Saves the generated G-code to a file at the specified file path.

        Args:
            file_path (str): The path to the file where the G-code will be saved.

        Returns:
            None.
        """
        self.gcode = open(file_path, 'w', encoding='utf-8')
        
        with open(self.start_gcode_path, 'r') as f:
            self.start_gcode_txt = f.read()
        self.gcode.write(self.start_gcode_txt)
        
        self.set_initial_settings()
        self.generate_gcode()
        
        with open(self.end_gcode_path, 'r') as f:
            self.end_gcode_txt = f.read()   
        self.gcode.write(self.end_gcode_txt)
        
        self.gcode.close()

    def generate_gcode(self):
        """
        Generates G-code instructions for the full object by iterating over its paths and calling
        the `apply_path_settings` and `generate_path_gcode` methods for each path.

        Returns:
            None
        """
        for path in self.full_object:
            self.apply_path_settings(path)
            self.generate_path_gcode(path)
    

    def generate_path_gcode(self, path):
        """
        Generates G-code instructions for printing a given path.

        Args:
            path (Path): The path to print.

        Returns:
            None

        Raises:
            None
        """
        txt = ''
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
        self.gcode.write(txt)

    def set_initial_settings(self):
        """
        Generates G-code commands to set the initial printer settings, such as bed and nozzle temperature, extrusion mode,
        and fan speed, based on the values defined in the `print_settings` module.

        Returns:
            str: A string containing the G-code commands to set the initial printer settings.
        """
        txt = '\n'
        txt += f'M140 S{print_settings.BED_TEMPERATURE} \n'
        txt += f'M190 S{print_settings.BED_TEMPERATURE} \n'
        txt += f'M104 S{print_settings.NOZZLE_TEMPERATURE} \n'
        txt += f'M109 S{print_settings.NOZZLE_TEMPERATURE} \n'
        txt += f'M83 ;relative extrusion mode \n'
        txt += f'M106 S{print_settings.FAN_SPEED} \n'
        self.gcode.write(txt)
    
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
        self.gcode.write(txt)

    def start_gcode(self, file_path):
        self.start_gcode_path = file_path
        

    def end_gcode(self, file_path):
        self.end_gcode_path = file_path

