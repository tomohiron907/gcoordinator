# gcoordinator
This package is for outputting G-codes for 3D printers in python.

# What is G-coordinator?
To use a 3D printer, basically, you need to prepare a 3D model and then slice it using slicing software to create G-code, which is then loaded into the printer. The gcoordinator is an open-source software in Python specifically designed for directly creating G-code. You can find it at the following URL: [https://github.com/tomohiron907/gcoordinator](https://github.com/tomohiron907/gcoordinator).

gcoordinatorは，G-coordinator(G-codeを生成するためのGUIアプリケーション)のG-code生成エンジンのみを切り出したライブラリです．造形のためのコードはほとんど同じですが，gcoordinatorライブラリでのコードがそのまま現在のG-coordinatorのGUIアプリで動作するわけではありません．しかし，G-coordinatorのversion3系列では，完全に同じコードで動作するようにする予定です．

gcoordinatorでは，G-code生成のライブラリとして開発をしているため，3D描画の機能は最低限のものになっています．