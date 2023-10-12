import numpy as np
from gcoordinator.print_settings import *
from gcoordinator.utils.coords import get_distances_between_coords

def extrusion_calculator(coords: np.ndarray) -> np.ndarray:
    """
    Calculates the amount of filament extrusion required for a given set of coordinates.
    
    Args:
        coords (np.ndarray): A 2D array of shape (n, 3) containing the x, y, and z coordinates of n points.
        
    Returns:
        np.ndarray: A 1D array of length n-1 containing the amount of filament extrusion required for each point.
    """
    distances = get_distances_between_coords(coords)
    extrusion = np.zeros(len(distances))
    for i, distance in enumerate(distances):
        # Calculate the extrusion for each distance
        # for more details, see formula 3 in the following paper:
        # https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7600913/
        numerator    = 4 * NOZZLE_DIAMETER * LAYER_HEIGHT * distance
        denominator  = np.pi * FILAMENT_DIAMETER**2
        extrusion[i] = numerator / denominator
    
    return extrusion
