## 自动安装ros依赖项

```
cd workspace
rosdep install --from-paths src --ignore-src -r -y
```



## Easy hand-eye calibration 的坑点

##### cv2 版本不对导致模块缺失

Python2 pip无法再安装，源码编译后手动添加路径

##### take sample后gui自动关闭

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

安装所需要的插件：C/C++，C++ Intellisense，CMake Tool

新建ROS workspace并执行catkin_make。

#### 编译快捷键

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
				"-j4",
				"-DCMAKE_BUILD_TYPE=Release",
				"-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
				"-DCMAKE_CXX_STANDARD=14"
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











