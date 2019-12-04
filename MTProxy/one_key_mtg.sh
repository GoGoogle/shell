#!/bin/bash
#一键脚本
#by BMWCTO 14:54 2019/12/4
#使用方式：./one_key_mtg.sh 端口

if [ "$#" -eq 0 ]; then
    echo "Usage: $(basename $0) <port>"
    exit 1
fi

wget -O mtg https://github.com/9seconds/mtg/releases/download/v1.0.1/mtg-linux-amd64 &&  chmod +x ./mtg
pass=$(./mtg generate-secret secured)
./mtg run -b0.0.0.0:$1 ${pass} >/dev/null &
echo ${pass}

