# 使用VSCode远程调试Linux服务器的可视化输出

安装Xserver 

下载安装包https://www.xquartz.org/

或者命令行安装

```
brew install xquartz
```

编辑Mac上的ssh配置

```
sudo nano /private/etc/ssh/ssh_config
# 添加
ForwardX11 yes
```

编辑文件/Users/lijian/.ssh/config

```
Host sever_name
  HostName sever_ip
  User sunlab
  ForwardAgent yes
  ForwardX11 yes
  ForwardX11Trusted yes
```





