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
ps -ef|grep ros
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

