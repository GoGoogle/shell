## 列出信号最强的前5个 WIFI
`iw wlan0 scan|egrep "signal:|SSID:"|sed -e "s/\tsignal: //" -e "s/\tSSID: //"|awk '{ORS = (NR % 2 == 0)? "\n" : " "; print}'|sort -nr|head -5`
