### rsyslog 日志服务器

`sudo vim /etc/rsyslog.conf`

```

$ egrep -v "^#|^$" /etc/rsyslog.conf

module(load="imuxsock") # provides support for local system logging

module(load="imklog")   # provides kernel logging support

module(load="imudp")

input(type="imudp" port="514")

$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat

$template FTM, "/var/log/0R/%fromhost-ip%-%$YEAR%%$MONTH%%$DAY%/%PROGRAMNAME%.log"

:fromhost-ip, !isequal, "127.0.0.1" ?FTM

& ~

$FileOwner root

$FileGroup adm

$FileCreateMode 0640

$DirCreateMode 0755

$Umask 0022

$WorkDirectory /var/spool/rsyslog

$IncludeConfig /etc/rsyslog.d/*.conf

auth,authpriv.*                 /var/log/auth.log

*.*;auth,authpriv.none          -/var/log/syslog

daemon.*                        -/var/log/daemon.log

kern.*                          -/var/log/kern.log

lpr.*                           -/var/log/lpr.log

mail.*                          -/var/log/mail.log

user.*                          -/var/log/user.log

mail.info                       -/var/log/mail.info

mail.warn                       -/var/log/mail.warn

mail.err                        /var/log/mail.err

*.=debug;\

        auth,authpriv.none;\

        news.none;mail.none     -/var/log/debug

*.=info;*.=notice;*.=warn;\

        auth,authpriv.none;\

        cron,daemon.none;\

        mail,news.none          -/var/log/messages

*.emerg                         :omusrmsg:*

```

`sudo systemctl restart rsyslog`
