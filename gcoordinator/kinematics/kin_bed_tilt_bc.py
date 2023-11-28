import os
import json
import math
import pickle
import numpy as np
from gcoordinator.kinematics.kin_base import Kinematics
from gcoordinator.settings            import template_settings



class BedTiltBC(Kinematics):
    """
    A class representing Bed Tilt kinematics. B is the rotation around the y-axis, C is the rotation around the z-axis.

    Attributes:
        None

    Methods:
        load_settings(): Loads the nozzle tilt and rotation settings from a pickle file and sets them as class attributes.
        generate_gcode_of_path(path): Generates G-code for a given path.
        update_attrs(path): Rearranges the coordinates of a given path and calculates the corresponding normals.
        calculate_extrusion(path): Calculates the extrusion required for a given path.
        
    """
    PRE_MOVE_DIV = 10

    @classmethod
    def load_settings(cls):
        """
        Loads the nozzle tilt and rotation settings from a pickle file and sets them as class attributes.

        Returns:
            None
        """
        try:
            settings_path = '.temp_config.json'
            with open(settings_path, 'r') as f:
                settings = json.load(f)
            
        except:
            settings = template_settings # gcoordinator/settings.py
        
        cls.tilt_code   = settings['Kinematics']['BedTiltBC']['tilt_code']
        cls.rot_code    = settings['Kinematics']['BedTiltBC']['rot_code']
        cls.tilt_offset = settings['Kinematics']['BedTiltBC']['tilt_offset']
        cls.rot_offset  = settings['Kinematics']['BedTiltBC']['rot_offset']
        cls.div_distance =settings['Kinematics']['BedTiltBC']['div_distance']
        
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
        BedTiltBC.load_settings()
        coords = []
        norms = []
        path.sub_segment_cnt = []
        ppx = px = path.x[0]
        ppy = py = path.y[0]
        ppz = pz = path.z[0]
        pprot = prot = path.rot[0]
        pptilt = ptilt = path.tilt[0]
        # start pos
        bx2 = px * math.cos(ptilt) - pz * math.sin(ptilt)
        by2 = py
        bz2 = px * math.sin(ptilt) + pz * math.cos(ptilt)
        bx3 = bx2 * math.cos(-prot) - by2 * math.sin(-prot)
        by3 = bx2 * math.sin(-prot) + by2 * math.cos(-prot)
        bz3 = bz2
        pos = (bx3, by3, bz3)
        coords.append(pos)
        # start norm
        mat = ( (math.cos(prot) * math.cos(-ptilt), math.sin(prot), math.cos(prot) * math.sin(-ptilt)),
                (-math.sin(prot) * math.cos(-ptilt), math.cos(prot), -math.sin(prot) * math.sin(-ptilt)),
                (-math.sin(-ptilt), 0, math.cos(-ptilt)) )
        norm = (mat[0][2], mat[1][2], mat[2][2])
        norms.append(norm)
        for (nx,ny,nz,nrot,ntilt) in zip(path.x[1:],path.y[1:],path.z[1:],path.rot[1:],path.tilt[1:]):
            # pre calc
            Dis = 0.0
            for i in range(BedTiltBC.PRE_MOVE_DIV):
                bx1 = (nx - px) * (i+1) / BedTiltBC.PRE_MOVE_DIV + px
                by1 = (ny - py) * (i+1) / BedTiltBC.PRE_MOVE_DIV + py
                bz1 = (nz - pz) * (i+1) / BedTiltBC.PRE_MOVE_DIV + pz
                brot = (nrot - prot) * (i+1) / BedTiltBC.PRE_MOVE_DIV + prot
                btilt = (ntilt - ptilt) * (i+1) / BedTiltBC.PRE_MOVE_DIV + ptilt
                # calc pos
                bx2 = bx1 * math.cos(btilt) - bz1 * math.sin(btilt)
                by2 = by1
                bz2 = bx1 * math.sin(btilt) + bz1 * math.cos(btilt)
                bx3 = bx2 * math.cos(-brot) - by2 * math.sin(-brot)
                by3 = bx2 * math.sin(-brot) + by2 * math.cos(-brot)
                bz3 = bz2
                # distance
                Dis += math.sqrt((bx3-ppx)**2 + (by3-ppy)**2 + (bz3-ppz)**2)
                # sub prev
                ppx = bx3
                ppy = by3
                ppz = bz3
                pprot = brot
                pptilt = btilt
            # calc coords
            div = (int)(np.ceil(Dis / BedTiltBC.div_distance))
            path.sub_segment_cnt.append(div)
            for i in range(div):
                bx1 = (nx - px) * (i+1) / div + px
                by1 = (ny - py) * (i+1) / div + py
                bz1 = (nz - pz) * (i+1) / div + pz
                brot = (nrot - prot) * (i+1) / div + prot
                btilt = (ntilt - ptilt) * (i+1) / div + ptilt
                # calc pos
                bx2 = bx1 * math.cos(btilt) - bz1 * math.sin(btilt)
                by2 = by1
                bz2 = bx1 * math.sin(btilt) + bz1 * math.cos(btilt)
                bx3 = bx2 * math.cos(-brot) - by2 * math.sin(-brot)
                by3 = bx2 * math.sin(-brot) + by2 * math.cos(-brot)
                bz3 = bz2
                pos = (bx3, by3, bz3)
                coords.append(pos)
                # calc norm
                mat = ( (math.cos(brot) * math.cos(-btilt), math.sin(brot), math.cos(brot) * math.sin(-btilt)),
                        (-math.sin(brot) * math.cos(-btilt), math.cos(brot), -math.sin(brot) * math.sin(-btilt)),
                        (-math.sin(-btilt), 0, math.cos(-btilt)) )
                norm = (mat[0][2], mat[1][2], mat[2][2])
                norms.append(norm)
            # prev
            px = bx3
            py = by3
            pz = bz3
            prot = brot
            ptilt = btilt
        center_x = center_y = center_z = 0.0
        for coord in coords:
            center_x += coord[0]
            center_y += coord[1]
            center_z += coord[2]
        center_x /= len(coords)
        center_y /= len(coords)
        center_z /= len(coords)
        path.coords = coords
        path.norms = norms
        path.center = (center_x, center_y, center_z)
        path.start_coord = path.coords[0]
        path.end_coord = path.coords[-1]
    
    @staticmethod
    def calculate_extrusion(path) -> np.ndarray:
        """
        Calculates the extrusion required for a given path.

        Args:
            path (Path): The path for which to calculate the extrusion.

        Returns:
            numpy.ndarray: An array of extrusion values, one for each segment of the path.

        Raises:
            None.
        """
        extrusion = np.array([])
        px = path.coords[0][0]
        py = path.coords[0][1]
        pz = path.coords[0][2]
        idx = 0
        for i in range(len(path.x[1:])):
            Dis = 0.0
            for j in range(path.sub_segment_cnt[i]):
                idx += 1
                nx = path.coords[idx][0]
                ny = path.coords[idx][1]
                nz = path.coords[idx][2]
                Dis += math.sqrt((nx-px)**2 + (ny-py)**2 + (nz-pz)**2)
                px = nx
                py = ny
                pz = nz
            AREA=(path.nozzle_diameter-path.layer_height)*(path.layer_height)+(path.layer_height/2)**2*np.pi
            extrusion = np.append(extrusion, 4*AREA*Dis/(np.pi*path.filament_diameter**2))

        return extrusion
    
    @staticmethod
    def generate_gcode_of_path(path) -> str:
        """
        Generates G-code for a given path.

        Args:
            path: A Path object representing the path to generate G-code for.

        Returns:
            A string containing the G-code for the given path.
        """
        extrusion = BedTiltBC.calculate_extrusion(path)
        txt = ''
        for i in range(len(path.x)-1):
            # print the path. move to the next point with extrusion
            txt += f'G1 F{path.print_speed} '
            txt += f'X{path.x[i+1]+path.x_origin:.5f} '
            txt += f'Y{path.y[i+1]+path.y_origin:.5f} '
            txt += f'Z{path.z[i+1]:.5f} '
            txt += f'{BedTiltBC.tilt_code}{path.tilt[i+1]+BedTiltBC.tilt_offset:.5f} '
            txt += f'{BedTiltBC.rot_code}{path.rot[i+1]+BedTiltBC.rot_offset:.5f} '
            txt += f'E{extrusion[i]:.5f}\n'
        return txt
    