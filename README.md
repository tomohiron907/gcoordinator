
# What is gcoordinator?
<img src="https://github.com/tomohiron907/G-coordinator/blob/main/img/G-coordinator.png?raw=true" width="100" height="100">

gcoordinator is a library used to generate G-code for 3D printers using Python. <br>
The development started with extracting the G-code generation engine from the GUI application G-coordinator [https://github.com/tomohiron907/G-coordinator].

With this library alone, you can perform 3D modeling, preview, G-code generation, and export. <br>
In the upcoming version 3 series of the GUI application, the plan is to fully migrate the internal generation engine to this library.

# Installation
You can install it using the following command:

```python
pip install gcoordinator
``` 

Since the dependencies include features that require specific versions to function properly, it is strongly recommended to create a virtual environment. 
Specifically, you will need pyqtgraph==0.13.2 and matplotlib==3.7.1.

# What is G-code?
In essence, the G-code used in 3D printing primarily consists of a series of coordinates where the nozzle moves. 
<br>It also includes parameters such as extrusion amount and movement speed, but these are automatically set and calculated within the library.
<br>
Therefore, when using the library for modeling, the only consideration needed is the three-dimensional coordinate sequence along which the nozzle moves.

# Usage
Below is a sample code for creating the simplest cylinder using the library:
```python
import gcoordinator as gc
import numpy as np


full_object = []
for height in range(100):
    arg  = np.linspace(0, 2*np.pi, 100)
    x = 10 * np.cos(arg)
    y = 10 * np.sin(arg)
    z = np.full_like(x, (height+1) * 0.2)
    wall = gc.Path(x, y, z)
    
    full_object.append(wall)

gc.show(full_object)


gcode = gc.GCode(full_object)
gcode.start_gcode("PATH TO YOUR START G-CODE")
gcode.end_gcode("PATH TO YOUR END G-CODE")
gcode.save('PATH OF YOUR G-CODE FILE TO SAVE')

```

## modeling
```python
for layer in range(100):
```
iterating through each layer using a for loop, ranging from layer 0 to layer 99.

<br>
Next, we set the angle (arg) in a numpy array from 0 to 2π to draw a circle.
<br>
Since the number of elements is set to 100, an exact regular 99-gon will be modeled.
If the radius is fixed at 10, the x coordinate is calculated as follows:

```python
radius×cos(arg)
```

The y coordinate is calculated as follows: <br>
```python
radius×sin(arg)
```
<br>

```python
z = np.full_like(x, (height+1) * 0.2)
```

As for the z coordinate in the height direction, an array with the same number of elements as arg is initialized with a value according to height.
<br>
The reason for adding 1 is that even if the height starts from 0, we want the first layer to be printed at a height of 0.2.

```python
wall = Path(x,y,z)
```

Create a Path from the x, y, and z coordinate sequences calculated above.

```python
full_object.append(wall)
```

Add the created Path to a list called full_object.
full_object is a list that stores all the Paths to be printed in the order of printing.
<br>
Note that the end point of the nth Path and the start point of the n+1th Path are automatically traveled.

## preview
```python
gc.show(full_object)
```

Preview all the Paths stored in full_object.

## G-code generation
```python
gcode = gc.GCode(full_object)
```

Convert all the Paths stored in full_object to G-code.

```python
gcode.start_gcode("PATH TO YOUR START G-CODE")
gcode.end_gcode("PATH TO YOUR END G-CODE")
```

Specify the G-code to be written at the beginning and end of the G-code.

```python
gcode.save('PATH OF YOUR G-CODE FILE TO SAVE')
```

Save the G-code.

# gcoordinaとは？
<img src="https://github.com/tomohiron907/G-coordinator/blob/main/img/G-coordinator.png?raw=true" width="100" height="100">

gcoordinatorは，pythonを用いて3Dプリンタ用G-codeを生成するためのライブラリです．<br>
GUIアプリのG-coordinator[https://github.com/tomohiron907/G-coordinator] のG-code生成エンジンの切り出しを発端に開発開始しました．
<br>
このライブラリ一つで，3次元の造形，プレビュー，G-codeの生成，書き出しが可能です．
<br>
GUIアプリのver3系列では，内部の生成エンジンを完全にこのライブラリに移行する予定です．

# インストール
以下のコマンドでインストール可能です．
```python
pip install gcoordinator
```
依存ライブラリの中に，指定のバージョンでないと動作しない機能が含まれるため，仮想環境を作成することを強くお勧めします．
<br>
具体的には，pyqtgraph==0.13.2, matplotlib==3.7.1が必要です．


# G-codeとは
そもそも，3Dプリンタで用いるG-codeとは，その大部分がノズルが移動していく座標列です．
他にも，押し出し量や移動スピードなどのパラメータも含まれますが，これらはライブラリ内で自動的に設定，計算されます．
<br>
従って，ライブラリを使用して造形を行う時に，考慮する必要があるのは，ノズルの移動していく3次元の座標列のみです．

# 使い方
以下に，最もシンプルな円柱を造形するためのサンプルコードを示します．
```python
import gcoordinator as gc
import numpy as np


full_object = []
for height in range(100):
    arg  = np.linspace(0, 2*np.pi, 100)
    x = 10 * np.cos(arg)
    y = 10 * np.sin(arg)
    z = np.full_like(x, (height+1) * 0.2)
    wall = gc.Path(x, y, z)
    
    full_object.append(wall)

gc.show(full_object)


gcode = gc.GCode(full_object)
gcode.start_gcode("PATH TO YOUR START G-CODE")
gcode.end_gcode("PATH TO YOUR END G-CODE")
gcode.save('PATH OF YOUR G-CODE FILE TO SAVE')

```
## 3次元造形
```python
for layer in range(100):
```
for文で各レイヤーについて繰り返しをしています．0層目から99層目まで繰り返されるイメージです．

<br>
次に，円を描くために，角度(arg)をnumpy arrayで0から2πの範囲で設定しています．
<br>
要素数は100としているため，正確には，正99角形が造形されます．
半径は10で固定すると，

x座標は， 
```python
半径×cos(arg)
```

y座標は， 
```python
半径×sin(arg)
```
より計算できます．

```python
z = np.full_like(x, (height+1) * 0.2)
```

高さ方向のz座標に関しては，argと同じ要素数のarrayをheightに応じて値を初期化しています．
<br>1を足しているのは，heightが0から始まっても，第一層目は高さ0.2の場所に印刷して欲しいからです．

```python
wall = Path(x,y,z)
```

上で計算したx,y,z座標列のPathを作成しています．

```python
full_object.append(wall)
```

作成したPathをfull_objectというリストに追加しています．
full_objectは，印刷すべき全てのPathを印刷順に格納したリストです．
<br>
なお，n番目のPathの終点とn+1番目のPathの始点とは，自動でトラベルするようになっています．

## プレビュー
```python
gc.show(full_object)
```

full_objectに格納された全てのPathをプレビューします．

## G-codeの生成
```python
gcode = gc.GCode(full_object)
```

full_objectに格納された全てのPathをG-codeに変換します．

```python
gcode.start_gcode("PATH TO YOUR START G-CODE")
gcode.end_gcode("PATH TO YOUR END G-CODE")
```

G-codeの先頭と末尾に書き込むG-codeを指定します．

```python
gcode.save('PATH OF YOUR G-CODE FILE TO SAVE')
```

G-codeを保存します．