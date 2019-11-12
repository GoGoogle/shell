#!/bin/bash
# 查股票并使用TG-Bot发送到TG-CHAT_ID
# 当前价：2914.8232
# 最高价：2918.3030
# 最低价：2891.5105
# 日期：2019-11-12
# 时间：15:11:59  
# 用法 ./Stock.sh sh000001
#1-30/29 9-11/1 * * 1-5 /root/stock.sh sh000001
#01,31,55 13-14/1 * * 1-5 /root/stock.sh sh000001

api_key=TG_BOT_KEY
chat_id=CHAT_ID

# Stock
stock=$(curl -s http://hq.sinajs.cn/list=$1 |iconv -f gb2312 -t utf-8| awk 'BEGIN{RS=",";} {print $0}'|sed -n '4,6p;31p;32p')
# All
report="%0A ====$1======== \
        %0A${stock} \
        %0A ==================== "
curl -s -X POST https://api.telegram.org/bot$api_key/sendMessage -d chat_id=$chat_id -d text="$report" > /dev/null

exit 0
