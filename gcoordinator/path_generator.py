import numpy as np
from gcoordinator.extrusion_calculator import extrusion_calculator

class Path():
    def __init__(self, x, y, z):
        self.x = np.array(x)
        self.y = np.array(y)
        self.z = np.array(z)
        self.coords = np.column_stack((self.x, self.y, self.z))

        self.extrusion = extrusion_calculator(self.coords)


