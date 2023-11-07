import numpy as np
import math
import gcoordinator as gc

LAYER =100
nozzle = 0.4
gc.load_settings("/Users/taniguchitomohiro/Documents/settings.json")

full_object=[]
for height in range(LAYER):
    arg = np.linspace(0, 2 * np.pi , 100)
    rad = 10
    x = rad * np.cos(arg)
    y = rad * np.sin(arg)
    z = np.full_like(x, 0)
    p = np.column_stack([x, y, z])
    phi = height/LAYER * np.pi/2
    R = 50
    
    X_0  = [R* np.cos(phi)-R, 0, R* np.sin(phi)]
    
    PHI_inv = np.array([[np.cos(phi), 0, -np.sin(phi)],
                                    [0, 1, 0],
                                    [np.sin(phi), 0, np.cos(phi)]])
    X = np.dot(  ( p + X_0), PHI_inv)
    
    x = X[:, 0]
    y = X[:, 1]
    z = X[:, 2]
    tilt = np.full_like(x, np.pi/2*height/LAYER)
    rot = np.full_like( tilt, 0)
    circle = gc.Path(x, y, z, rot , tilt)
    full_object.append(circle)

gc.show(full_object)

gcode = gc.GCode(full_object)
gcode.start_gcode("/Users/taniguchitomohiro/Documents/default_gcode/start_gcode.txt")
gcode.end_gcode("/Users/taniguchitomohiro/Documents/default_gcode/end_gcode.txt")
gcode.save('test.gcode')
