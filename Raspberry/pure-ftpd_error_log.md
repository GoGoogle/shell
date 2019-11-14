## FTP排查问题
#200 TYPE is now ASCII

### 先把日志跟踪打开

`sudo echo 'yes' > /etc/pure-ftpd/conf/VerboseLog`

### 或用vim编辑一个，内容为yes

`sudo vim > /etc/pure-ftpd/conf/VerboseLog`

### 然后重启一下服务

`sudo service pure-ftpd restart`

### 然后去测试登录之后回来看系统日志（最后一100行）

`tail -n 100 /var/log/syslog`

### 先检查配置文件

`sudo cat /etc/pure-ftpd/pure-ftpd.conf|grep assive`

### 参照以下配置，一个被动模式的端口范围，一个强制被动模式ip
```
PassivePortRange             30000 50000
ForcePassiveIP               192.168.0.1
```

### 顺便看看这个配置文件存不存在，里面有没有已经配置好的强制被模式IP

`sudo cat /etc/pure-ftpd/conf/ForcePassiveIP`

### 追完日志解决后记得删除日志配置，并重启服务
```sudo rm -f /etc/pure-ftpd/conf/VerboseLog
sudo service pure-ftpd restart
```
