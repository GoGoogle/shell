#!/bin/bash
## PIP UPDATE EFB And WeChat-Slave

echo "==OneKey Upgrade EFB==" >>efb_bak_ver.txt
pip3 freeze|egrep "ehforwarderbot|efb-telegram-master|efb-wechat-slave" >>efb_bak_ver.txt
date >>efb_bak_ver.txt
echo >>efb_bak_ver.txt
systemctl stop efb
pip3 install --upgrade ehforwarderbot efb-telegram-master efb-wechat-slave
systemctl start efb
systemctl status efb
