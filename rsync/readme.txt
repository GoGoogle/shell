## 使用rsync协议进行文件同步
## 完全同步：无差异同步（客户端有，服务端就有；客户端没有，服务端就没有）---谨慎使用
rsync -avz --delete bmw_backup@127.0.0.1::ftp /root/ftp2/ --password-file=/root/.rsync.passwd

## 安装rsync服务
apt install -y rsync

#服务端：
mkdir /root/ftp
echo testTXT > /root/ftp/000test.txt
chmod 777 /etc/rsyncd.secrets;echo "bmw_backup:1234">/etc/rsyncd.secrets && chmod 600 /etc/rsyncd.secrets

#配置文件：
vim /etc/rsyncd.conf

log file=/var/log/rsyncd
[ftp]
        comment = testFTP
        path = /root/ftp/
        use chroot = yes
#       max connections=10
        lock file = /var/lock/rsyncd
# the default for read only is yes...
        read only = yes
        list = yes
        uid = root
        gid = root
#       exclude = 
#       exclude from = 
#       include =
#       include from =
        auth users = bmw_backup
        secrets file = /etc/rsyncd.secrets
        strict modes = yes
#       hosts allow =
#       hosts deny =
        ignore errors = no
        ignore nonreadable = yes
        transfer logging = no
        log format = %t: host %h (%a) %o %f (%l bytes). Total %b bytes.
        timeout = 600
        refuse options = checksum dry-run
        dont compress = *.gz *.tgz *.zip *.z *.rpm *.deb *.iso *.bz2 *.tbz

##服务端可能需要加载配置文件启动
rsync --daemon --config=/etc/rsyncd.conf

##依次为 开机自启\启动\查看状态\重启
systemctl enable rsync
systemctl start rsync
systemctl -l status rsync
systemctl restart rsync

#客户端：
chmod 777 /root/.rsync.passwd;echo 1234>/root/.rsync.passwd && chmod 600 /root/.rsync.passwd
#每分钟同步一下（仅用于测试）crontab -e
*/1 * * * * /usr/bin/rsync -avz bmw_backup@127.0.0.1::ftp /root/ftp2/ --password-file=/root/.rsync.passwd

#本机测试
rsync -avz bmw_backup@127.0.0.1::ftp /root/ftp2/ --password-file=/root/.rsync.passwd
#若本机测试没有问题，就得查防火墙和端口，默认端口873通不通


参考：https://blog.51cto.com/jinlong/2091904
