# shell
一些Linux脚本
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
