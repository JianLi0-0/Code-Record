### 配置ROS环境

```
打开终端，运行clion.sh（~/.bashrc中的source /opt/ros/noetic/setup.bash）

打开项目，选择功能包的CMakeLists.txt（ros工作空间在上一层目录）

设置CMake Option为： -DCATKIN_DEVEL_PREFIX=../clion_devel

构建目录： ../clion_build
```

### 本地代码远程编译

#### docker设置
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

在docker中输入下面指令获取开发ros所需环境变量,
```
ros_env="AMENT_PREFIX_PATH CMAKE_PREFIX_PATH COLCON_PREFIX_PATH PKG_CONFIG_PATH PYTHONPATH LD_LIBRARY_PATH PATH ROS_DISTRO ROS_PYTHON_VERSION ROS_LOCALHOST_ONLY ROS_VERSION"
env_string=""
for e in ${ros_env}; do
    env_string+="$e=${!e};"
done
echo "$env_string"
```

#### 本机设置
在设置中的 Build、Eexcution、Deployment  —>  Toolchains  —>  点击+号添加[docker toolchain]，选择Remote host

新建ssh连接，若并在docker中安装相应的编译调试工具

在Build、Eexcution、Deployment -> CMake 中添加远程CMake
```
Toolchain: docker toolchain
CMake Options: -DCATKIN_DEVEL_PREFIX=../devel(根目录为build)
Build directory: clion/build
Enviroment: 输入前面获取的docker中的环境变量，例如: AMENT_PREFIX_PATH=;CMAKE_PREFIX_PATH=/opt/ros/noetic; ...
```

重载CMake

第一次应该会报错，因为编译生成的文件不会自动同步到本机，需手动同步

打开Tools -> Deployment -> Browse Remote Host可查看远程文件目录

找到/tmp/tmp.xxx，右键选择下载到本地（Tools -> Deployment -> Configurations, 在Mappings页中可查看映射地址）

再次重载CMake

### 设置terminal路径为当前目录
```
在设置窗口中，展开 Tools 选项，然后选择 Terminal。

找到 Starting directory: 选项。

将其设置为 $PROJECT_DIR$，这样 Terminal 就会默认在当前项目目录打开。
```


