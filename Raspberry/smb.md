## 为共享加密码 ##

### 编辑smb.conf配置文件，把guest ok标记为no ###
```
sudo nano /etc/samba/smb.conf
guest ok = no
```

### 重启smbd服务 ###
`sudo systemctl restart smbd`

### 设置用户名为pi，以及新密码 ###
`sudo smbpasswd -a pi`
