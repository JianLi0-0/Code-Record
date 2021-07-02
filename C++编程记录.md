## 使用eigen3库

安装eigen3

```
sudo apt install libeigen3-dev
```

### 方法1:

若默认安装的在/usr/include/eigen3/Eigen或者/usr/local/include/eigen3/Eigen下，将Eigen文件夹拷贝一到/usr/include 下

```
sudo cp -r /usr/include/eigen3/Eigen /usr/include
```

因为eigen3 被默认安装到了usr/local/include或者usr/include下，在很多程序中include时经常使用#include <Eigen/Dense>而不是使用#include <eigen3/Eigen/Dense>，所以要做处理，否则一些程序在编译时会因找不到Eigen/Dense而报错。上面指令将usr/local/include/eigen3文件夹中的Eigen文件复制到上一层文件夹（直接放到/usr/local/include中，否则系统无法默认搜索到 -> 此时只能在CMakeLists.txt用include_libraries（绝对路径））。

在CMakelist中添加

```
find_package(Eigen3 REQUIRED)
include_directories(${Eigen3_INCLUDE_DIRS})
```

### 方法2: 

链接对应的文件

```
sudo ln -s /usr/include/eigen3 /usr/local/include/eigen3
```

执行此命令是因为 eigen 库默认安装在了 /usr/include/eigen3/Eigen 路径下，需使用下面命令映射到 /usr/include 路径下。

linux下的命令： sudo ln -s 源文件 目标文件

这是一个常用的linux命令，功能是为源文件在目标文件的位置建立一个同步的链接，当二者建立联系后即可在源文件中访问目标文件。 链接有两种，一种被称为硬链接（Hard Link），另一种被称为符号链接（Symbolic Link）。 建立硬链接时，链接文件和被链接文件必须位于同一个文件系统中，并且不能建立指向目录的硬链接。默认情况下，ln产生硬链接。如果给ln命令加上- s选项，则建立符号链接。

