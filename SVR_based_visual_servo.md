## SimpleITK医疗图像数据格式转换
```
import SimpleITK as sitk

file = "01a_us_tal.mnc"
written = "im_t4" + ".mhd"

reader = sitk.ImageFileReader()
reader.SetImageIO("MINCImageIO")
inputImageFileName = file
reader.SetFileName(inputImageFileName)
image = reader.Execute();

writer = sitk.ImageFileWriter()
outputImageFileName = written
writer.SetFileName(outputImageFileName)
writer.Execute(image)

# GDCMImageIO
# JPEGImageIO ( *.jpg, *.JPG, *.jpeg, *.JPEG )
# MINCImageIO ( *.mnc, *.MNC )
# MetaImageIO ( *.mha, *.mhd )
# NiftiImageIO ( *.nia, *.nii, *.nii.gz, *.hdr, *.img, *.img.gz )
# PNGImageIO ( *.png, *.PNG )
```

## Ubuntu编译ITK

ITK源码下载

https://itk.org/download/

CMAKE下载

https://cmake.org/download/

安装步骤

http://www.bewindoweb.com/184.html

## 生成OPTIM头文件库

```
git clone https://github.com/kthohr/optim.git
cd optim
./configure --header-only-version
```

## 下载最新版本eigen3

```
git clone https://gitlab.com/libeigen/eigen.git
```

eigenhi头文件库，不用安装，直接在CMakelist.txt中添加

```
include_directories( "/.../eigen" )
```

## 编译elastix

```
git clone https://github.com/SuperElastix/elastix.git
cd elastix
mkdir build
cd build
ccmake .. # ()

```

## 离散SVR环境搭建

```
conda create -n svr_py2 python=2.7
pip install itk simpleitk ipyparallel numpy scipy -i https://mirrors.aliyun.com/pypi/simple/
ipcluster start -n 4
python DiscreteOptimizedRegistration.py
```

### 安装Ultrasound Image相关软件包

```
(version smaller than python 3.9)
pip3 install PyV4L2Camera opencv-python -i https://mirrors.aliyun.com/pypi/simple/

```

## 使用Armadillo矩阵运算库

在CMakeLists.txt中添加:

```
set(ARMADILLO_INCLUDE_DIR /home/sunlab/Desktop/SVR/armadillo/include)
find_package(Armadillo REQUIRED)
include_directories(${ARMADILLO_INCLUDE_DIRS})
```

