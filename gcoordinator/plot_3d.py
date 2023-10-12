import sys
import colorsys
import numpy as np
import pyqtgraph.opengl as gl
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QVBoxLayout



class Plot3D:
    """3次元プロットを担うクラス"""
    def __init__(self):
        self.generate_window()
        self.draw_grid()
    
    #==================== ウィンドウを生成 =====================================
    def generate_window(self):
        self.app = QApplication(sys.argv)
        self.window = QMainWindow()
        self.window.setGeometry(100, 100, 1200, 1000)  

        self.central_widget = QWidget()
        self.layout = QVBoxLayout(self.central_widget)
        self.window.setCentralWidget(self.central_widget)

        self.view = gl.GLViewWidget()
        self.view.setCameraPosition(distance=180)
        self.layout.addWidget(self.view)
    

    #==================== グリッドを描画 =====================================
    def draw_grid(self):
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


    #==================== 線を描画する関数 =====================================
    def plot_line(self, pos, color):
        plt = gl.GLLinePlotItem(pos=pos, color=color, width=3, antialias=True)
        self.view.addItem(plt)

    #==================== 点を描画する関数 =====================================
    def scatter_point(self, pos, color):
        plt = gl.GLScatterPlotItem(pos=pos, color=color, size=15)
        self.view.addItem(plt)

    #==================== ウィンドウを表示 =====================================
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


def show(full_object):
    graph = Plot3D()
    graph.show(full_object)


if __name__ == '__main__':
    graph = Plot3D()
    graph.plot_line(pos=np.array([[0,0,0],[1,1,1]]), color=np.array([[1,0,0,1],[0,1,0,1]]))
    graph.show()