"""
This module provides a class for generating and displaying 3D plots using PyQtGraph's GLViewWidget.

The Plot3D class contains methods for initializing a 3D plot window, adding a 3D grid to the view, 
and creating and drawing a sequence of coordinates that the nozzle moves through the entire list of full_objects.

Functions:
    show(full_object): Displays a 3D plot of the given object.

Classes:
    Plot3D: A class for generating and displaying 3D plots using PyQtGraph's GLViewWidget.

"""

import sys
import colorsys
import numpy as np
import pyqtgraph.opengl as gl
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QVBoxLayout
from gcoordinator.path_generator import flatten_path_list


def show(full_object):
    """
    Displays a 3D plot of the given object.

    Args:
        full_object(list of Path object): The object to be plotted.

    Returns:
        None.
    """
    # full_object is a list of Path or PathList objects
    # flatten_path_list() flattens the list of PathList objects into a list of Path objects
    full_object = flatten_path_list(full_object)
    # Plot3D cladd can only plot a list of Path objects
    graph = Plot3D()
    graph.show(full_object)

class Plot3D:
    """
    A class for generating and displaying 3D plots using PyQtGraph's GLViewWidget.

    Attributes:
        app (QApplication): The Qt application instance.
        window (QMainWindow): The main window of the application.
        central_widget (QWidget): The central widget of the main window.
        layout (QVBoxLayout): The layout of the central widget.
        view (GLViewWidget): The 3D view widget.
    
    Methods:
        __init__(): Initializes the class instance and generates the window and grid.
        generate_window(): Initializes and displays a 3D plot window using PyQtGraph's GLViewWidget.
        draw_grid(): Adds a 3D grid to the view, with axis labels and tick marks.
        show(full_object): Creates and draws a sequence of coordinates that the nozzle moves through the entire list of full_objects.
    """
    def __init__(self):
        self.generate_window()
        self.draw_grid()
    
    def generate_window(self):
        """
        Initializes and displays a 3D plot window using PyQtGraph's GLViewWidget.

        Returns:
            None
        """
        self.app = QApplication(sys.argv)
        self.window = QMainWindow()
        self.window.setGeometry(100, 100, 1200, 1000)  

        self.central_widget = QWidget()
        self.layout = QVBoxLayout(self.central_widget)
        self.window.setCentralWidget(self.central_widget)

        self.view = gl.GLViewWidget()
        self.view.setCameraPosition(distance=180)
        self.layout.addWidget(self.view)
    
    def draw_grid(self):
        """
        Add a 3D grid to the view, with axis labels and tick marks.
        """
        gz = gl.GLGridItem()
        gz.setSize(200, 200)
        gz.setSpacing(10,10)

        axis = gl.GLAxisItem()
        axis.setSize(50,50,50)
        x_text = gl.GLTextItem()
        x_text.setData(pos=(50,0,0),text = 'x')
        y_text = gl.GLTextItem()
        y_text.setData(pos=(0,50,0),text = 'y')
        z_text = gl.GLTextItem()
        z_text.setData(pos=(0,0,50),text = 'z')
        
        self.view.addItem(axis)
        self.view.addItem(x_text)
        self.view.addItem(y_text)
        self.view.addItem(z_text)
        self.view.addItem(gz)

    def show(self, full_object):
        """Create and draw a sequence of coordinates that the nozzle moves through the entire list of full_objects

        Args:
            widget (GLViewWidget): widget of graphics view
            full_object (list): list of path objects
        """
        pos_array = []
        colors = []
        for idx, path in enumerate(full_object):
            coord = path.coords
            color = np.zeros((len(coord), 4))
            for i in range(len(coord)):
                z = coord[i][2]
                hue = z % 360  
                rgb = colorsys.hsv_to_rgb(hue/360, 1, 1)  
                color[i] = (*rgb, 1)  

            coord = np.insert(coord, 1, coord[0], axis=0)
            coord = np.append(coord, [coord[-1]], axis=0)
            
            color = np.insert(color, 0, (1, 1, 1, 0.1), axis=0)
            color = np.append(color, [(1, 1, 1, 0.1)], axis=0)
            
            pos_array.append(coord)
            colors.append(color)
        
        pos_array = np.concatenate(pos_array)
        colors = np.concatenate(colors)
        plt = gl.GLLinePlotItem(pos=pos_array, color=colors, width=0.5, antialias=True)
        self.view.addItem(plt)
        self.window.show()
        self.app.exec_()



