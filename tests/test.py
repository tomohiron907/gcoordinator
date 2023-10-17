import gcoordinator as gc
import numpy as np


full_object = []
for layer in range(100):
    arg = np.linspace(0, 2*np.pi, 5)
    x = 10 * np.cos(arg)
    y = 10 * np.sin(arg)
    z = np.full_like(x, (layer+1) * 0.2 - 0.1)
    if layer<50:
        wall = gc.Path(x, y, z, retraction = True)
    else:
        wall = gc.Path(x, y, z, z_hop=True)
    
    full_object.append(wall)

gc.show(full_object)


gcode = gc.GCode(full_object)
gcode.start_gcode("/Users/taniguchitomohiro/Documents/default_gcode/start_gcode.txt")
gcode.end_gcode("/Users/taniguchitomohiro/Documents/default_gcode/end_gcode.txt")
gcode.save('test.gcode')
