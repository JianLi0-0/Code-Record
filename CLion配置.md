### 配置ROS环境

```
打开终端，运行clion.sh（~/.bashrc中的source /opt/ros/noetic/setup.bash）

打开项目，选择功能包的CMakeLists.txt（ros工作空间在上一层目录）

设置CMake Option为： -DCATKIN_DEVEL_PREFIX=../clion_devel

构建目录： ../clion_build
```

### 本地代码远程编译
假设是远程环境为docker

安装ssh-server
```
sudo apt-get install openssl openssh-server
```

然后修改ssh配置允许root登录，在docker容器内，编辑文件/etc/ssh/sshd_config，添加一行PermitRootLogin yes表示ssh允许root登录
```
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
```

设置ssh自启动
```
touch /root/start_ssh.sh
chmod +x /root/start_ssh.sh
```

start_ssh.sh脚本内容
```
#!/bin/bash   

LOGTIME=$(date "+%Y-%m-%d %H:%M:%S") 
echo "[$LOGTIME] startup run..." >>/root/start_ssh.log 
service ssh start >>/root/start_ssh.log   ###其他服务也可这么实现
```

在 /root/.bashrc 文件末尾加入如下内容
```
# startup run 
if [ -f /root/start_ssh.sh ]; then       
    . /root/start_ssh.sh 
fi
```


在docker中输入下面指令获取开发ros所需环境变量
```
ros_env="AMENT_PREFIX_PATH CMAKE_PREFIX_PATH COLCON_PREFIX_PATH PKG_CONFIG_PATH PYTHONPATH LD_LIBRARY_PATH PATH ROS_DISTRO ROS_PYTHON_VERSION ROS_LOCALHOST_ONLY ROS_VERSION"
env_string=""
for e in ${ros_env}; do
    env_string+="$e=${!e};"
done
echo "$env_string"
```


### 设置terminal路径为当前目录
```
在设置窗口中，展开 Tools 选项，然后选择 Terminal。

找到 Starting directory: 选项。

将其设置为 $PROJECT_DIR$，这样 Terminal 就会默认在当前项目目录打开。
```


