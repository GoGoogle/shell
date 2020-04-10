#!/bin/bash
#一键脚本
#by BMWCTO 14:54 2019/12/4
#使用方式：./one_key_mtg.sh 端口

if [ "$#" -eq 0 ]; then
    echo "Usage: $(basename $0) <port>"
    exit 1
fi

wget -O mtg https://github.com/9seconds/mtg/releases/latest/download/mtg-linux-amd64 &&  chmod +x ./mtg
kill $(ps aux --sort=start_time | grep mtg | awk 'NR==1{print $2}')
./mtg run -b0.0.0.0:$1 $(./mtg generate-secret secured) >/dev/null &
echo $(ps aux --sort=start_time | grep mtg | awk 'NR==1{print $NF}')
