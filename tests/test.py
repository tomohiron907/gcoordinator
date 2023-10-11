import gcoordinator as gc
import numpy as np


full_object = []
for layer in range(100):
    arg = np.linspace(0, 2*np.pi, 5)
    x = 10 * np.cos(arg)
    y = 10 * np.sin(arg)
    z = np.full_like(x, layer * 0.1)
    wall = gc.Path(x, y, z)
    full_object.append(wall)


gcode = gc.GCode(full_object)

gcode.save('test.gcode')
