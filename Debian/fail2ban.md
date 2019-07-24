### BAN掉不明IP

#### 安装及使用

`apt install -y fail2ban`

`cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local`

`/etc/fail2ban/jail.local`

`systemctl restart fail2ban`

`iptables -L`

`fail2ban-client status sshd&&lastb -n15`

#### fail2ban
```
/usr/bin/fail2ban-client status $1

/usr/bin/fail2ban-client set sshd banip $1
sleep 1s
/usr/bin/fail2ban-client status sshd

/usr/bin/fail2ban-client set sshd unbanip $1
sleep 1s
/usr/bin/fail2ban-client status sshd
```

