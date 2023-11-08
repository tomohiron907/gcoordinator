import os
import math
import pickle
import numpy as np
from gcoordinator.kinematics.kin_base import Kinematics

class NozzleTilt(Kinematics):
    """
    A class representing Nozzle Tilt kinematics.

    Attributes:
        None

    Methods:
        load_settings(): Loads the nozzle tilt and rotation settings from a pickle file and sets them as class attributes.
        generate_gcode_of_path(path): Generates G-code for a given path.
        update_attrs(path): Rearranges the coordinates of a given path and calculates the corresponding normals.


        -- inherited from Kinematics: 
        calculate_extrusion(path): Calculates the extrusion required for a given path.
    """
        
    @classmethod
    def load_settings(cls):
        """
        Loads the nozzle tilt and rotation settings from a pickle file and sets them as class attributes.

        Returns:
            None
        """
        settings_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'settings/settings.pickle')
        with open(settings_path, 'rb') as f:
            settings = pickle.load(f)
        cls.tilt_code   = settings['Kinematics']['NozzleTilt']['tilt_code']
        cls.rot_code    = settings['Kinematics']['NozzleTilt']['rot_code']
        cls.tilt_offset = settings['Kinematics']['NozzleTilt']['tilt_offset']
        cls.rot_offset  = settings['Kinematics']['NozzleTilt']['rot_offset']
        
    @staticmethod
    def update_attrs(path) -> None:
        """
        Rearranges the coordinates of a given path and calculates the corresponding normals.

        Args:
            path (Path): The path to be rearranged.

        Returns:
            None

        Raises:
            None
        """
        path.coords = np.column_stack([path.x, path.y, path.z])
        path.norms = []
        for (rot,tilt) in zip(path.rot,path.tilt):
            rot = -rot +math.pi / 2.0
            mat = ( (math.cos(rot), math.sin(rot) * math.cos(tilt), math.sin(rot) * math.sin(tilt)),
                    (-math.sin(rot), math.cos(rot) * math.cos(tilt), math.cos(rot) * math.sin(tilt)),
                    (0, -math.sin(tilt), math.cos(tilt)))
            norm = (mat[0][2], mat[1][2], mat[2][2])
            path.norms.append(norm)        
            
        path.center      = np.array([np.mean(path.x), np.mean(path.y), np.mean(path.z)])
        path.start_coord = path.coords[0]
        path.end_coord   = path.coords[-1]
        
    @staticmethod
    def generate_gcode_of_path(path) -> str:
        """
        Generates G-code for a given path.

        Args:
            path: A Path object representing the path to generate G-code for.

        Returns:
            A string containing the G-code for the given path.
        """
        extrusion = NozzleTilt.calculate_extrusion(path)
        txt = ''
        for i in range(len(path.x)-1):
            # print the path. move to the next point with extrusion
            txt += f'G1 F{path.print_speed} '
            txt += f'X{path.x[i+1]+path.x_origin:.5f} '
            txt += f'Y{path.y[i+1]+path.y_origin:.5f} '
            txt += f'Z{path.z[i+1]:.5f} '
            txt += f'{NozzleTilt.tilt_code}{path.tilt[i+1]+NozzleTilt.tilt_offset:.5f} '
            txt += f'{NozzleTilt.rot_code}{path.rot[i+1]+NozzleTilt.rot_offset:.5f} '
            txt += f'E{extrusion[i]:.5f}\n'
        return txt