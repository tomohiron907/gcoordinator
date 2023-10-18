import gcoordinator as gc
import numpy as np

full_object = []
for layer in range(100):
    arg = np.linspace(0, 2*np.pi, 5)
    x = 30 * np.cos(arg)
    y = 30 * np.sin(arg)
    z = np.full_like(x, (layer+1) * 0.2 - 0.1)
    wall = gc.Path(x, y, z)
    full_object.append(wall)
    infill = gc.gyroid_infill(wall, density=0.85)
    full_object.append(infill)
    
gc.show(full_object)

gcode = gc.GCode(full_object)
gcode.start_gcode("/Users/taniguchitomohiro/Documents/default_gcode/start_gcode.txt")
gcode.end_gcode("/Users/taniguchitomohiro/Documents/default_gcode/end_gcode.txt")
gcode.save('test.gcode')
