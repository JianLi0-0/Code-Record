## 配置ROS环境

```
打开终端，运行clion.sh（~/.bashrc中的source /opt/ros/noetic/setup.bash）

打开项目，选择功能包的CMakeLists.txt（ros工作空间在上一层目录）

设置CMake Option为： -DCATKIN_DEVEL_PREFIX=../clion_devel

构建目录： ../clion_build
```

## 交叉编译
#### 原理
所谓的交叉编译，其实我们可以从编译原理上理解这个步骤，C++的编译大致可以分为预编译、编译和链接三个步骤，所以我们只要保证预编译和编译使用的编译工具是目标平台的配套工具，最后链接的库文件是目标平台的库文件，即可保证交叉编译的正确性。
#### 安装arm的编译工具链
```
sudo apt install gcc-aarch64-linux-gnu
sudo apt install g++-aarch64-linux-gnu
```
#### 准备arm编译环境
新建目录arm-sysroot，新建工具链配置文件toolchain.cmake
```
#File rostoolchain.cmake
INCLUDE(CMakeForceCompiler)
set(CMAKE_SYSTEM_NAME Linux)
message(STATUS "home path $ENV{HOME}")
set(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-gnu-g++)
set(CMAKE_CXX_FLAGS -fpermissive)
set(CMAKE_C_FLAGS -fpermissive)

set(SYSROOT /userdata/workdir/arm-sysroot)

set(CMAKE_FIND_ROOT_PATH  ${SYSROOT}/ros/noetic ${SYSROOT})

set(CMAKE_LIBRARY_PATH
        ${SYSROOT}/usr/lib
        ${SYSROOT}/usr/local/lib
        ${SYSROOT}/usr/lib/aarch64-linux-gnu)

set(CMAKE_INCLUDE_PATH
        ${SYSROOT}/usr/include
        ${SYSROOT}/usr/include/freetype2
        ${SYSROOT}/usr/include/aarch64-linux-gnu
        ${SYSROOT}/usr/local/include)

set(LD_LIBRARY_PATH
        ${SYSROOT}/usr/lib
        ${SYSROOT}/usr/local/lib
        ${SYSROOT}/usr/lib/aarch64-linux-gnu)
message(STATUS "rostoolchain LD_LIBRARY_PATH ${LD_LIBRARY_PATH}")

set(PCL_DIR ${SYSROOT}/usr/lib/aarch64-linux-gnu/cmake/pcl)


set(CMAKE_CROSSCOMPILING true)
message("${CMAKE_CROSSCOMPILING}")

# Have to set this one to BOTH, to allow CMake to find rospack
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)#FOR COMPILE TOOL WORKS
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
```
将docker或者目标机的/opt/ros、/usr/lib、/usr/include、/usr/local复制到目录arm-sysroot下

将arm-sysroot/opt/ros/noetic/share目录下所有的xxx.cmake中的系统路径替换成arm-sysroot的路径
(P.S. 引用cv_bridge时可能会找不到libgdal.so，在cv_bridgeConfig.cmake中的set(libraries)后面加入该库的路径arm-sysroot/usr/lib/libgdal.so.26)

建立软链接，指向arm环境
```
sudo ln -s arm-sysroot/usr/lib/aarch64-linux-gnu /usr/lib/aarch64-linux-gnu
```

#### CLion配置CMake
CMake Option:
```
-DCATKIN_DEVEL_PREFIX=../arm-devel -DCMAKE_TOOLCHAIN_FILE=/userdata/workdir/arm-sysroot/toolchain.cmake -DCMAKE_INSTALL_PREFIX:PATH=../arm-install
```

Build Directory: ```../arm-build```

Build Options: ```-- -j 10 install```

Enviroment: 
```
AMENT_PREFIX_PATH=;CMAKE_PREFIX_PATH=/userdata/workdir/arm-sysroot/ros/noetic;COLCON_PREFIX_PATH=;LD_LIBRARY_PATH=/userdata/workdir/arm-sysroot/ros/noetic/lib;PKG_CONFIG_PATH=/userdata/workdir/arm-sysroot/ros/noetic/lib/pkgconfig;PYTHONPATH=/userdata/workdir/arm-sysroot/ros/noetic/lib/python3/dist-packages;ROS_DISTRO=noetic;ROS_LOCALHOST_ONLY=;ROS_PYTHON_VERSION=3;ROS_VERSION=1;PATH=/userdata/workdir/arm-sysroot/ros/noetic/bin:/userdata/workdir/arm-sysroot/usr/local/sbin:/userdata/workdir/arm-sysroot/usr/local/bin:/userdata/workdir/arm-sysroot/usr/sbin:/userdata/workdir/arm-sysroot/usr/bin:/sbin:/bin:/userdata/workdir/arm-sysroot/usr/games:/userdata/workdir/arm-sysroot/usr/local/games:/snap/bin
```
#### 配置同步目录
在Deployment中将目标机的install目录与本机的install目录同步，编译完成后再上传



## 本地代码远程编译

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

## 设置terminal路径为当前目录
```
在设置窗口中，展开 Tools 选项，然后选择 Terminal。

找到 Starting directory: 选项。

将其设置为 $PROJECT_DIR$，这样 Terminal 就会默认在当前项目目录打开。
```


