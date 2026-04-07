import math
import numpy as np
import gcoordinator as gc

gc.load_settings("sample_settings/settings.json")

LAYER = 40

full_object=[]
for height in range(LAYER):
    arg = np.linspace(0, 2*np.pi, 100)
    x = 50 * np.cos(arg)
    y = 50 * np.sin(arg)
    z = np.full_like(arg, (height+1) * 0.2)
    wall = gc.Path(x, y, z)
    full_object.append(wall)
    infill = gc.gyroid_infill(wall, infill_distance=5)
    full_object.append(infill)
gc.preview(full_object)

gcode = gc.GCode(full_object)
gcode.start_gcode("sample_settings/start_gcode.txt")
gcode.end_gcode("sample_settings/end_gcode.txt")
gcode.save('fcylinder.gcode')