本地电脑VS Code安装插件 Remote Development

在本地电脑.ssh目录下生成公钥(id_rsa.pub)和私钥(id_rsa)

```
cd ~/.ssh
ssh-keygen
```

生成公钥和私钥，添加公钥authorized_keys，并复制到服务器上

```
cat id_rsa.pub >> authorized_keys
ls  =>查看确保生成功authorized_keys
scp authorized_keys name@server_ip:/home/name/.ssh
```

在服务器上更改私钥权限。打开SSH配置文件，禁用密码登陆(选项)。最后重启ssh服务

```
cd /home/name/.ssh
sudo chmod 600 authorized_keys
sudo chmod 700 ~/.ssh

sudo nano /etc/ssh/sshd_config
"RSAAuthentication yes
 PubkeyAuthentication yes
 PasswordAuthentication no"

service sshd restart
```

最后修改本机电脑配置ssh文件

```
Host name
  HostName ip
  User username
  IdentityFile /path/.ssh/id_rsa
```

若提示“ Permissions 0644 for ‘/xx/.ssh/id_rsa.pub’ are too open”，使用以下指令更改私钥权限

```
chmod 0600 ~/.ssh/id_rsa
```

若提示“Enter passphrase for key”，执行下面代码

```
ssh-add -K ~/.ssh/id_rsa
```