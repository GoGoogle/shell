### 定时开关某一个无线网络

root@MyAP:~# `crontab -e`
  ```
  #凌晨5点关闭所有WIFI网络（因为直接开启会出现一些不可预知的结果，所以先关闭一分钟，再开启）
  00 05 * * * /sbin/wifi down
  #凌晨5点零1开启所有网络（包括访客）
  01 05 * * * /sbin/wifi up
  #下午6点半关闭访客网络
  30 18 * * * /sbin/ifconfig wlan9Guest down
  ```
root@MyAP:~# /etc/init.d/cron start

root@MyAP:~# /etc/init.d/cron enable

### 配置[opkg代理支持](https://openwrt.org/zh/docs/techref/opkg)

  root@MyAP:~# vi /etc/opkg.conf
  
  `option http_proxy http://10.0.0.18:8118/`

### SQM限速

root@MyAP:~# opkg install sqm-scripts

root@MyAP:~# opkg install luci-app-sqm

root@MyAP:~# cat /etc/config/sqm
```
config queue 'eth1'
        option qdisc 'fq_codel'
        option script 'simple.qos'
        option qdisc_advanced '0'
        option linklayer 'none'
        option enabled '1'
        option debug_logging '0'
        option verbosity '5'
        option download '500'
        option interface 'wlan9Guest'
        option upload '12000'
```
root@MyAP:~# /etc/init.d/sqm start

root@MyAP:~# /etc/init.d/sqm enable
