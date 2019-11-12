#!/bin/bash
## 发送VPS信息到TG

api_key=API_TOKEN
chat_id=Chat_id

# VPS status monitor to telegram
# Version
ver=$(lsb_release -d)
# Node
node=$(uname -n)
# Kernel
kern=$(uname -r)
# Bandwidth
RX=$(/usr/sbin/ifconfig|grep packets|head -n2|grep RX|awk '{print $6,$7}')
TX=$(/usr/sbin/ifconfig|grep packets|head -n2|grep TX|awk '{print $6,$7}')
# Uptime
upth=$(uptime | cut -d',' -f1)
# Disk
dfh=($(df -h | grep vda ))
# Memory
freeh=($(free -h | grep Mem ))
# Top Processes
toph=$(ps -eo pmem,pcpu,cmd | sort -k 1 -nr | head -2)
# Myip grep -A 4 ldms test.acl
myip=$(sed -n '/'ldms'/,$p' test.acl)
# All
report="%0A ==================== \
        %0A VPS STATUS(${node}): \
        %0A \
        ${ver} \
        %0A Kernel: ${kern} \
        %0A \
        %0A UPTIME: ${upth} \
        %0A DISK: Total: ${dfh[1]} Used:${dfh[2]} Avail:${dfh[3]} Used%:${dfh[4]} \
        %0A BANDWIDTH: Total: RX: ${RX} TX:${TX} \
        %0A MEMORY: Total: ${freeh[1]} Used:${freeh[2]} Avail:${freeh[3]} \
        %0A \
        %0A ----------------------------- \
        %0A TOP Processes(pmem,pcpu,cmd): \
        %0A ----------------------------- \
        %0A ${toph}
        %0A ----------------------------- \
        %0A ${myip}"

curl -s -X POST https://api.telegram.org/bot$api_key/sendMessage -d chat_id=$chat_id -d text="$report" > /dev/null

exit 0
