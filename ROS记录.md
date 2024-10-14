## 远程ssh后台运行程序
tmux new -s nav
tmux attach nav
tmux kill-session -t nav
tmux kill-server

## 指定build与devel目录
```
catkin_make --build arm-build/build -DCATKIN_DEVEL_PREFIX=$PWD/arm-build/devel
```

## 自动安装ros依赖项

```
cd workspace
rosdep install --from-paths src --ignore-src -r -y
```

## rosdep init失败

```
sudo pip install rosdepc
sudo rosdepc init
rosdepc update
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








