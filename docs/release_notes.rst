Release Notes
=============

G-coordinator ver3.0.0
----------------------

.. note::
    
    This version is a major update from ver2.0.0. 
    Due to the lack of backward compatibility with version 2, some adjustments are necessary for the modeling code created in version 2 to work with version 3.

The internal G-code generation process has been standardized to the gcoordinator library version 0.0.14. 
As a result, some aspects of the fabrication code processing have been modified. 

In G-coordinator ver2, the code for shaping was written inside a function called object_modeling(). 
In ver3, that restriction has been removed, and now shaping can be done through the execution of pure Python code. 

By passing the list of path objects, full_object, to the gui_export() function, you can preview and export G-code within the application.

.. raw:: html

   <div style="display: flex; justify-content: space-between;">

.. code-block:: python

    # ver2 series code
    import numpy as np
    import print_settings 
    from path_generator import *
    from infill_generator import *

    def object_modeling():
        full_object=[]
        for height in range(100):
            arg = np.linspace(0, 2*np.pi, 100)
            x = 10 * np.cos(arg)
            y = 10 * np.sin(arg)
            z = np.full_like(arg, (height+1) * 0.2)
            wall = Path(x, y, z)
            full_object.append(wall)
            
        return full_object

.. code-block:: python

    # ver3 series code
    import numpy as np
    import gcoordinator as gc

    full_object = []
    for height in range(100):
        arg = np.linspace(0, 2*np.pi, 100)
        x = 10 * np.cos(arg)
        y = 10 * np.sin(arg)
        z = np.full_like(arg, (height+1) * 0.2)
        wall = gc.Path(x, y, z)
        full_object.append(wall)

    gc.gui_export(full_object)


.. raw:: html

   </div>



Furthermore, there have been slight changes in the way functions like Path(), Transform class, and gyroid_infill() are called.
To avoid namespace pollution, it is recommended to access objects from the gcoordinator library by calling them through the gc alias.


.. raw:: html

   <div style="display: flex; justify-content: space-between;">

.. code-block:: python

    # ver2 series code
    from path_generator import *
    from infill_generator import *

    wall = Path(x, y, z)
    outer_wall = Transform.offset(wall, 0.4)
    infill = gyroid_infill(wall, infill_distance=2)

.. code-block:: python

    # ver3 series code
    import gcoordinator as gc


    wall = gc.Path(x, y, z)
    outer_wall = gc.Transform.offset(wall, 0.4)
    infill = gc.gyroid_infill(wall, infill_distance=2)


.. raw:: html

   </div>


In version 3, code refactoring was performed to streamline the complexity of the code, 
leading to certain functions being restricted or deprecated. 
Specifically:

- Functionality to access parameter tree values in the editor
- The print() function in the editor
- The Transform.fill() function
These features are not included in ver3.0.0; however, we plan to reintroduce them in a more improved form through future updates.