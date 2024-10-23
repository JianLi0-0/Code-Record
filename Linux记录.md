### 命令行快捷指令(写入~/.bashrc)
```
function hm_scp(){
echo "file name: $1"
scp -r $1 honymow@10.42.0.1:/userdata/workdir/
}

function hm_remote_159_scp(){
echo "file name: $1"
scp -r honymow@192.168.1.159:$1 .
}

alias hm_export='export ROS_MASTER_URI=http://10.42.0.1:11311 export ROS_HOSTNAME=10.42.0.223'
alias hm_ssh='sshpass -p 'honymow' ssh -o StrictHostKeyChecking=no honymow@10.42.0.1'
```

### linux生僻指令

```
nautilus . #当前打开文件夹gui
```

## 使用cnpmjs镜像加速github代码下载

例如，将

```
git clone https://github.com/acado/acado.git
```

改成

```
git clone https://github.com.cnpmjs.org/acado/acado.git
```

##  使用命令行加入服务器内网

```
sudo openconnect server_ip -u user_name
```

##  kill 进程

查看pid：

```
ps -ef | grep roscore
```

杀死进程：

```
kill pid
```

根据名称杀死相关所有进程，例如，关闭所有ros进程：

```
ps aux | grep ros |  awk '{print $2}' | xargs kill -9
```

## ubuntu 扩展屏幕

查看设备名称

```
xrandr
```

克隆：-auto(最高分辨率)

```
xrandr –output HDMI2 –same-as HDMI1 –auto
```

右桌面扩展

```
xrandr –output HDMI2 –right-of HDMI1 –auto
```

## dpkg安装失败，提示缺少依赖

```
sudo dpkg -i xxx.deb
sudo apt-get install -f
```

## pip install 无法调用 python2

```
python2 -m pip install package_name
```

## 使用国内源 pip install

```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple package_name
阿里云：http://mirrors.aliyun.com/pypi/simple/
中科大 https://pypi.mirrors.ustc.edu.cn/simple/
```

## 开机自启动sunlogin

```
gnome-session-properties
/usr/local/sunlogin/bin/sunloginclient
```

### .gitignore file 不生效

缓存 gitignore只能忽略那些原来没有被track的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore是无效的。

解决方案: 清理缓存

```
git rm -r --cached .
git add .
git commit -m 'update .gitignore'
```

### Anaconda关闭终端自动激活base

```
conda config --set auto_activate_base false
```

### 绑定usb、video等设备号

```
$ lsusb 查看编号
Bus 001 Device 013: ID 534d:2109 

$ cd /etc/udev/rules.d
$ sudo touch new.rules $$ sudo gedit new.rules
在文件中添加以下内容：
KERNEL=="video*", ATTRS{idVendor}=="534d", ATTRS{idProduct}=="2109", MODE:="0777", SYMLINK+="UltrasoundImage"

$ sudo udevadm trigger
$ ls -l /dev |grep video
lrwxrwxrwx  1 root root          6 Aug 17 17:17 UltrasoundImage -> video0
crwxrw-rwx+ 1 root root    81,   0 Aug 17 17:17 video0
$ ls /dev/UltrasoundImage
```

### Python3 Anaconda 安装 opencv

```
pip install opencv-contrib-python
```



