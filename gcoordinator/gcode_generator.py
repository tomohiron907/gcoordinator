import os
import numpy as np
from  gcoordinator.print_settings import *


class GCode:
    def __init__(self, full_object:list) -> None:
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
            txt += f'G0 F{TRAVEL_SPEED} X{path.x[0]+X_ORIGIN} Y{path.y[0]+Y_ORIGIN} Z{path.z[0]}\n'
            for i in range(len(path.x)-1):
                txt += f'G1 F{PRINT_SPEED} '
                txt += f'X{path.x[i+1]+X_ORIGIN} '
                txt += f'Y{path.y[i+1]+Y_ORIGIN} '
                txt += f'Z{path.z[i+1]} '
                txt += f'E{path.extrusion[i]}\n'
        return txt
    

    def save(self, file_path):
        """
        Save the generated G-code to a file.

        Args:
            file_path (str): The path to the file to save the G-code to.

        Returns:
            None
        """
        with open(file_path, 'w') as f:
            f.write(self.txt)


    def start_gcode(self, file_path):
        """
        Prepends the contents of a file to the current G-code text.

        Args:
            file_path (str): The path to the file to be prepended.

        Returns:
            None
        """
        with open(file_path, 'r') as f:
            self.txt = f.read() + self.txt
        
    
    def end_gcode(self, file_path):
        """
        Appends the contents of the file at the given file path to the current G-code text.

        Args:
            file_path (str): The path to the file to be appended.

        Returns:
            None
        """
        with open(file_path, 'r') as f:
            self.txt = self.txt + f.read()