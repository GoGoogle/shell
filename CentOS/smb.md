也许smb在Linux里面是通用的，但还是要记录一下。

### 安装smb
  `yum install samba`
  
### samba服务的主配置文件
  `/etc/samba/smb.conf`
  
  ```[root@CentOS7 home]# cat /etc/samba/smb.conf
[global]
    workgroup = WORKGROUP
    server string = Samba Server Version %v
    netbios name = ShareSERVER
    unix charset = utf8
    security = user
    map to guest = Bad User
    passdb backend = tdbsam
    disable spoolss = yes
    load printers = no
    cups options = raw
[public]
    comment = public share
    path = /home/public
    public = yes
    writable = yes
    browseable = yes
[lwr1]
    comment = lwr1
    path = /home/lwr1
    writable = yes
    browseable = yes
    valid users = lwr1
    write list = lwr1
    printable = no
    create mask = 0644
    directory mask = 0755
[lwr2]
    comment = lwr2
    path = /home/lwr2
    writable = yes
    browseable = yes
    valid users = lwr2
    write list = lwr2
    printable = no
    create mask = 0644
    directory mask = 0755
```

### 创建用户lwr1\lwr2目录，同时默认创建了用户组lwr1\lwr2
  ```
  useradd -d /home/lwr1 -m -s /sbin/nologin lwr1
  useradd -d /home/lwr2 -m -s /sbin/nologin lwr2
  
  #创建smb用户，smb用户必须是系统已经存在的用户,执行命令后输入两次密码即创建成功
  pdbedit  -a -u lwr1
  pdbedit  -a -u lwr2
```

### 设置密码
  `smbpasswd lwr1`

  `smbpasswd lwr2`



### 公共目录无法写入的解决方案
  保证目录权限为nobody，而且777啥的
  `chown -R nobody:nobody /home/public/`
  `chmod 777 /home/public/`
  
  然后smb配置为 `writable = yes`
  
  最后就是这个锅
  在RHEL5下，由于SELinux的限制，会造成Samba所共享的目录即便将权限设为777也无法写入的情况
  `/usr/sbin/setsebool -P allow_smbd_anon_write=1`
  
  `chcon -t public_content_rw_t /home/public`
  
