import numpy as np
from gcoordinator.utils.coords import get_distances_between_coords


class Kinematics:
    """
    The base class for all kinematics classes.
    """

    @staticmethod
    def update_attrs(path) -> None:
        """
        Rearranges the coordinates of a given path and calculates the corresponding normals.

        Args:
            path (Path): The path to be rearranged.

        Returns:
            tuple: A tuple containing the rearranged coordinates and the corresponding normals.

        Raises:
            None
        """
        path.coords = np.column_stack([path.x, path.y, path.z])
        path.center = np.array([np.mean(path.x), np.mean(path.y), np.mean(path.z)])
        path.start_coord = path.coords[0]
        path.end_coord = path.coords[-1]
        norms = []
        for i in range(len(path.coords)):
            norms.append((0, 0, 1))
        path.norms = norms
    
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
        coords = path.coords
        distances = get_distances_between_coords(coords)
        extrusion = np.zeros(len(distances))
        for i, distance in enumerate(distances):
            # Calculate the extrusion for each distance
            # for more details, see formula 3 in the following paper:
            # https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7600913/
            numerator    = 4 * path.nozzle_diameter * path.layer_height * distance
            denominator  = np.pi * path.filament_diameter**2
            extrusion[i] = numerator / denominator * path.extrusion_multiplier
        
        return extrusion