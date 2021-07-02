## 复现目标检测 YOLO v3

首先确定driver、cuda以及cudnn的版本，确定它们相互兼容。

### 安装驱动

#### 方法一：

先根据显卡型号查询适合的driver

https://www.nvidia.com/Download/index.aspx

再查看相应driver适配的cuda版本

https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#abstract

禁用nouveau:

```
sudo gedit /etc/modprobe.d/blacklist.conf
最后一行添加：blacklist nouveau
sudo update-initramfs -u
sudo reboot
lsmod | grep nouveau  #没有输出，即说明安装成功
```

关闭显示模式:

```
Ctrl+Alt+F1 #进入tty终端模式
service lightdm stop #关闭显示管理
```

安装：

```
sudo sh NVIDIA-Linux-x86_64-415.27.run --no-opengl-files #全程回车
```



#### 方法二：

```
sudo apt-get update
sudo apt-cache search nvidia-*
sudo apt-get install nvidia-384
sudo reboot
nvidia-smi
```

### 安装cuda：

[CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive)

```
sudo sh cuda_8.0.61_375.26_linux.run –no-opengl-files
```

Ctrl + C 可以跳过冗长的条款。遇到选项Do you want to install a symbolic link at /usr/local/cuda时，选择yes。

将下面的内容拷贝到 ~/.bashrc中，注意CUDA版本

```
export CUDA_HOME=/usr/local/cuda-8.0
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64
export PATH=${CUDA_HOME}/bin:${PATH}
```

source .bashrc， 然后

 ```
 nvcc -V
 ```

查看CUDA是否安装成功。

### 安装cudnn：

[CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive)

```
sudo cp cuda/include/cudnn.h /usr/local/cuda/include/
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64/
sudo chmod a+r /usr/local/cuda/include/cudnn.h
sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
```

### 如何卸载CUDA：

```
sudo /usr/local/cuda-10.0/bin/uninstall_cuda_10.0.pl
sudo rm -rf /usr/local/cuda-10.0/
```

## 安装anaconda：

到官网下载 [Anaconda.sh](https://www.anaconda.com/products/individual)

```
./Anaconda.sh
```

下载yolov3代码：

```
git clone https://github.com/adriansarno/PyTorch-YOLOv3.git
```

创建conda环境：

```
cd PyTorch-YOLOv3
conda env create -f condayolo_env.yml
```

随后按照README.md进行测试。

制作数据集：

训练：

在anaconda环境中(base: python 3.8.3)，安装opencv：

```
pip3 install opencv-python
```

在anaconda环境中，安装cuda和cudnn：

```
conda install cudatoolkit=8.0 -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/linux-64/
conda install cudnn=6.0.21 -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/linux-64/
```

以上全是无用功。

python3安装opencv

```
pip3 install --upgrade pip
pip3 install scikit-build
pip3 install opencv-python
```

## GUI开发

安装qt5

```
sudo apt-get install qt5-default qtcreator
```

安装pyside2

```
pip3 install pyside2 -i https://mirrors.aliyun.com/pypi/simple/
```

安装redis

```
pip3 install redis -i https://mirrors.aliyun.com/pypi/simple/
sudo apt-get install redis-server
```