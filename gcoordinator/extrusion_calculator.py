import numpy as np
from gcoordinator.print_settings import *
from gcoordinator.utils.coords import get_distances_between_coords


def extrusion_calculator(path):
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