## 复现目标检测 YOLO v3

首先确定driver、cuda以及cudnn的版本，确定它们相互兼容。

安装Nvidia显卡驱动：

```
sudo apt-get update
sudo apt-cache search nvidia-*
sudo apt-get install nvidia-384
sudo reboot
nvidia-smi
```

安装cuda：

[CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive)

```
sudo sh cuda_8.0.61_375.26_linux.run
```

Ctrl + C 可以跳过冗长的条款。遇到选项Do you want to install a symbolic link at /usr/local/cuda时，选择yes。

将下面的内容拷贝到 ~/.bashrc中，注意CUDA版本

```
export CUDA_HOME=/usr/local/cuda-8.0
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64
export PATH=${CUDA_HOME}/bin:${PATH}
```

source .bashrc， 然后 nvcc -V 查看CUDA是否安装成功。

安装cudnn：

[CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive)

```
sudo cp cuda/include/cudnn.h /usr/local/cuda/include/
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64/
sudo chmod a+r /usr/local/cuda/include/cudnn.h
sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
```

如何卸载CUDA：

```
sudo /usr/local/cuda-10.0/bin/uninstall_cuda_10.0.pl
sudo rm -rf /usr/local/cuda-10.0/
```

安装anaconda：

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
pip3 install redis
sudo apt-get install redis-server
```