Simple Rectangle
=================

Let's write code to draw a rectangle on a plane. 

.. image:: ../_static/tutorials/1/rectangle_path.png
    :scale: 50 %
    :alt: rectangle path



First, let's import the gcoordinator library:

.. code-block:: python

    import gcoordinator as gc   

The coordinates for the nozzle's movement are (0, 0, 0), (10, 0, 0), (10, 10, 0), (0, 10, 0), and (0, 0, 0). 
Considering the starting and ending points, we'll sequentially move through these five coordinates.

In gcoordinator, it is necessary to have coordinate sequences for x, y, and z. 
Therefore, we'll create coordinate sequences like the following. 

.. code-block:: python

    x = [0, 10.0, 10.0, 0, 0]
    y = [0, 0, 10.0, 10.0, 0]
    z = [0, 0, 0, 0, 0]
    

From these sequences, we'll create the nozzle path.

.. code-block:: python

    rectangle = gc.path(x, y, z)

We'll add the created path to a list called "full_object." 

.. code-block:: python

    full_object = []
    full_object.append(rectangle)   

Passing full_object to gc.preview() displays the preview.
The same call works with both the G-coordinator app and the gcoordinator VSCode extension.

.. code-block:: python

    gc.preview(full_object)

.. note::

    gc.gui_export() is kept as an alias of gc.preview(), so existing code keeps working as is.

Here is the final code to draw a rectangle on a plane:

.. code-block:: python

    import gcoordinator as gc

    full_object = []

    x = [0, 10.0, 10.0, 0, 0]
    y = [0, 0, 10.0, 10.0, 0]
    z = [0, 0, 0, 0, 0]

    rectangle = gc.path(x, y, z)
    full_object.append(rectangle)

    gc.preview(full_object)
