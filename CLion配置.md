### 配置ROS环境


打开终端，运行clion.sh（~/.bashrc中的source /opt/ros/noetic/setup.bash）

打开项目，选择功能包的CMakeLists.txt（ros工作空间在上一层目录）

设置CMake Option为： -DCATKIN_DEVEL_PREFIX=../clion_devel

构建目录： ../clion_build



### 设置terminal路径为当前目录

在设置窗口中，展开 Tools 选项，然后选择 Terminal。

找到 Starting directory: 选项。

将其设置为 $PROJECT_DIR$，这样 Terminal 就会默认在当前项目目录打开。



