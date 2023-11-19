Before using software
=====================

Before using G-coordinator/gcoordinator, let's take a moment to review what G-code is. 
The image below shows G-code opened in Repetier. 

.. image:: ../_static/reptier.png
   :alt: repetier

In essence, it consists largely of lines like "G1 F800 X114.97987 Y105.63424 Z2.00000 E0.00589" being repeated extensively. 
This command instructs the nozzle to move from the current position to the coordinates X114.97987 Y105.63424 Z2.00000 at a feed rate of 800 mm/min while extruding 0.00589 mm of filament.

To break it down further, the elements to be controlled via G-code are the three coordinates (x, y, z), speed, and extrusion amount—amounting to a total of five parameters. 

Additionally, both speed and extrusion can be automatically determined by the G-coordinator (though specific manual settings are also possible). 
Therefore, the key consideration lies in determining the coordinates where the nozzle should move.