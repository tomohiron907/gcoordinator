import numpy as np
import math
from gcoordinator.kinematics.kin_base import Kinematics

class Cartesian(Kinematics):
    """
    A class representing Cartesian kinematics.

    Attributes:
        None

    Methods:
        generate_gcode_of_path(path): Generates G-code for a given path.

        -- inherited from Kinematics: 
        calculate_extrusion(path): Calculates the extrusion required for a given path.
        update_attrs(path): Rearranges the coordinates of a given path and calculates the corresponding normals.

    """
    @staticmethod
    def generate_gcode_of_path(path) -> str:
        """
        Generates G-code for a given path.

        Args:
            path (Path): A Path object representing the path to generate G-code for.

        Returns:
            str: A string containing the G-code for the given path.
        """
        extrusion = Cartesian.calculate_extrusion(path)
        txt = ''
        for i in range(len(path.x)-1):
            # print the path. move to the next point with extrusion
            txt += f'G1 F{path.print_speed} '
            txt += f'X{path.x[i+1]+path.x_origin:.5f} '
            txt += f'Y{path.y[i+1]+path.y_origin:.5f} '
            txt += f'Z{path.z[i+1]:.5f} '
            txt += f'E{extrusion[i]:.5f}\n'
        return txt