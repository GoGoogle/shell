## 使用rsync协议进行文件同步

#服务端：
mkdir /root/ftp
echo testTXT > /root/ftp/000test.txt
chmod 777 /etc/rsyncd.secrets;echo "bmw_backup:1234">/etc/rsyncd.secrets && chmod 600 /etc/rsyncd.secrets

#客户端：
chmod 777 /root/.rsync.passwd;echo '1234' > /root/.rsync.passwd && chmod 600 /root/.rsync.passwd

#本机测试
rsync -avz lc_backup@127.0.0.1::ftp /root/ftp2/ --password-file=/root/.rsync.passwd

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

#每分钟同步一下（仅用于测试）
*/1 * * * * /usr/bin/rsync -avz lc_backup@127.0.0.1::ftp /root/ftp2/ --password-file=/root/.rsync.passwd
