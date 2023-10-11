import numpy as np

def get_distances_between_coords(coordinates: np.ndarray) -> np.ndarray:
    """
    Given a list of coordinates, calculate the distance between the nth and n+1st coordinates and store it in the nth ndarray of the distance.
    
    Args:
    coordinates (np.ndarray): A numpy array of shape (n, m) where n is the number of coordinates and m is the number of dimensions
    
    Returns:
    np.ndarray: A numpy array of shape (n-1,) containing the distances between the coordinates
    """
    distances = np.empty(coordinates.shape[0] - 1)
    for i in range(coordinates.shape[0] - 1):
        distance = np.linalg.norm(coordinates[i+1] - coordinates[i])
        distances[i] = distance
    return distances


if __name__ == '__main__':
    # Test calculate_distances
    coordinates = np.array([[0, 0, 0], [1, 1, 1], [2, 2, 2]])
    distances = get_distances_between_coords(coordinates)
    print(distances)
    # Expected output: [1.73205081 1.73205081]