### nginx日志相关配置

#### 配置日志保留天数

  - 配置文件位置：`vim /etc/logrotate.d/nginx`
  - 参数，默认为14天：`rotate 14`
  - 更改天数后，运行生效 `logrotate /etc/logrotate.d/nginx`

#### 查看日志
- 统计访问URL统计PV	`awk '{print $7}' /var/log/nginx/access.log|wc -l`
- 根据访问IP统计UV		`awk '{print $1}' /var/log/nginx/access.log|sort | uniq -c |wc -l`		
- 查询访问最频繁的IP	`awk '{print $1}' /var/log/nginx/access.log|sort | uniq -c |sort -n -k 1 -r|more`
- 查询访问最频繁的URL	`awk '{print $7}' /var/log/nginx/access.log|sort | uniq -c |sort -n -k 1 -r|more`
- 根据时间段统计查看	`cat /var/log/nginx/access.log| sed -n '/14\/Mar\/2018:15/,/20\/Aug\/2018:16/p'|more`
- 统计当天访问URL统计PV	```cat /var/log/nginx/access.log| grep `LANG=C date +%d/%b/%Y`|awk '{print $7}'|wc -l```
- 过去7天至今（1周内）```cat /var/log/nginx/access.log|sed -n "/`LANG=C LC_TIME=C date "+%d\/%b\/%Y" -d -7day`/,\$p"|awk '{print $4,$7}'|wc -l```
