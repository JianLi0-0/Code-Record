## 自动安装ros依赖项

```
cd workspace
rosdep install --from-paths src --ignore-src -r -y
```



## Easy hand-eye calibration 的坑点

#### Python2.7+ROS环境:AttributeError:‘module’ has no attribute ‘CALIB_HAND_EYE_TSAI’

上面问题是库引用冲突或者只安装了旧版的opencv。

Python2 pip无法再安装新版的opencv，需要源码编译后手动添加路径。

找到easy_handeye/handeye_calibration_backend_opencv.py，在import cv2前后加入

```
import sys
sys.path.append("/home/ur5e/local/lib/python2.7/dist-packages/") #python2 cv2的源码安装路径
sys.path.remove('/opt/ros/kinetic/lib/python2.7/dist-packages')
import cv2
sys.path.append('/opt/ros/kinetic/lib/python2.7/dist-packages')
```

#### Take sample后gui自动关闭

需要在rviz中打开image插件（不能用camera），订阅/aruco_xxx/result才能正常运行



## rosdep update出现<urlopen error [Errno 111] Connection refused>

将原有的nameserver这一行注释，并添加下面两行：

```
sudo gedit /etc/resolv.conf

nameserver 8.8.8.8 #google域名服务器
nameserver 8.8.4.4 #google域名服务器
```

保存退出，执行

```
sudo  apt-get update
rosdep update
```





## ubuntu16 kinetic gazebo7 升级 gazebo9

```
sudo apt-get remove ros-kinetic-gazebo*
sudo apt-get remove libgazebo*
sudo apt-get remove gazebo*
sudo nano /etc/apt/sources.list.d/gazebo-stable.list
添加 “deb http://packages.osrfoundation.org/gazebo/ubuntu-stable xenial main”
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get install ros-kinetic-gazebo9-*
```





## 配置VS Code进行ROS开发

安装所需要的插件：ROS，C/C++，C++ Intellisense，CMake Tool。

新建ROS workspace并执行catkin_make。

#### 定义编译快捷键，生成compile_commands.json

点击菜单栏： Terminal->Configure default build task，选择catkin_make: build，然后在.vscode的文件夹会生成并同时打开一个task.json文件，将其修改成

```
{
	"version": "2.0.0",
	"tasks": [
		{
			"label": "catkin_make",
			"type": "shell",
			"command": "catkin_make",
			"args": [
				"-j8",
				"-DCMAKE_BUILD_TYPE=Release",
				"-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
				"-DCMAKE_CXX_STANDARD=14",
				"-DCATKIN_WHITELIST_PACKAGES="
			],
			"problemMatcher": [
				"$catkin-gcc"
			],
			"group": {
				"kind": "build",
				"isDefault": true
			}
		}
	]
}
```

Ctrl + shift+B 选择 catkin_make 之后在devel下面会生成一个compile_commands.json的文件，其实就是规定了到哪里去编译什么文件。

#### 代码补全

在c_cpp_properties.json中添加

```
"compileCommands": "${workspaceFolder}/build/compile_commands.json"
```

这个是C/C++ extension 的 auto config intellisense 功能。

(或者 ctrl+shift+p，输入C/C++:Edit Configuration进行调整 ？ )





## 在python3中使用ros

```
python3 -m pip install rospkg
```



## 安装PCL

```
sudo apt install libpcl-dev
```



## 当gazebo版本与ros默认版本冲突时

```
sudo apt install ros-kinetic-desktop-full
```

上述指令默认安装gazebo7。

若想安装其他版本，使用：

```
sudo apt install ros-kinetic-desktop
```

再独立安装想要的gazebo版本。

最后用下列指令安装gazebo-ros：

```
sudo apt-get install ros-kinetic-gazebo8-ros-pkgs ros-kinetic-gazebo8-ros-control
```



## Gazebo启动黑屏或者卡住

原因是gazebo尝试下载模型，但是无法下载

解决方法：

1. 断网

2. 手动下载gazebo模型

   ```
   cd ~/.gazebo/
   mkdir -p models
   cd ~/.gazebo/models/
   wget http://file.ncnynl.com/ros/gazebo_models.txt
   wget -i gazebo_models.txt
   ls model.tar.g* | xargs -n1 tar xzvf
   ```




## 零散命令

```
查看摄像头图像：rosrun image_view image_view image:=/aruco_single/result
保存视频：rosrun image_view video_recorder image:="/usb_cam/image_raw" _filename:="/home/user/video.avi"
```







