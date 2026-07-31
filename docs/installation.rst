Installation
============

G-coordinator: GUI app  
----------------------
The GUI application for G-coordinator is available in both Mac (.app) and Windows (.exe) versions. 
Please download the respective compressed files (.dmg, .zip) from the links below.
https://github.com/tomohiron907/G-coordinator/releases


Furthermore, if you have a Python environment set up, you can launch the GUI by creating a clone of the Git repository and executing main.py. 
In this case, please install the necessary libraries for startup using the following command:

.. code-block:: bash

    $ pip install -r requirements.txt

Additionally, when launching, make sure to move to the "src" directory and execute main.py.

gcoordinator: Python library
---------------------------
The Python library for G-coordinator is available on PyPI.

We strongly recommend setting up your environment with `uv <https://docs.astral.sh/uv/>`_:

.. code-block:: bash

   uv init --python 3.12 my-prints
   cd my-prints
   uv add gcoordinator
   uv run main.py

The dependencies pin specific versions, so gcoordinator must live in its own virtual environment.
uv creates and manages one for you.
Python 3.12 is recommended because the pinned numpy has no prebuilt wheels for 3.13 and later.

If you prefer to manage the environment yourself, you can also install it with pip:

.. code-block:: bash

   pip install gcoordinator
