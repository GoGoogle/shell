# shell
一些Linux脚本
# Cisco
关于思科的一些笔记，其实有很多很多，慢慢的搬上来

# testip
测试IP的脚本

PING 4 次，取平均值res 的整数num，小于150ms的显示ok，否则显示fail。

用法：testip.sh ip.txt列表文件（一行一个IPV4）

# update_eav
病毒库更新，结构：
<pre>
update_eav
├── 8002.reg
├── eav_bak
│   ├── eav_2018-11-05-00-01-01.zip
│   └── eav_2018-12-03-00-01-01.zip
├── eav.sh
├── index.php
├── offline
│   ├── nod04AC.nup
│   ├── xxx.nup
│   ├── nodFE87.nup
│   └── update.ver
├── offline_update_eav.zip
└── update_eav.sh
</pre>


# 关于用PuTTY
因为putty使用的是自己的ppk文件，因此需要对id_rsa进行转换。这项需求需要使用puttygen来实现。
打开puttygen.exe，load现有的id_rsa文件。如果设置了私钥密码，则要在key passphrase中输入密码并确认。点击“save private key”，保存为putty的.ppk文件。
在putty中，设置需要登录的服务器ip和端口之后，在Connection - SSH - Auth中的Private key file for authentication中选择生成的ppk文件。这样就可以使用密钥进行登录了。
也可以在Connection - Data 的Auto-login username中设置好登录的用户，那么打开session就可以自动连接上服务器了。
