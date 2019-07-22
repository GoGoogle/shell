#!/bin/bash
## 带数据库整站备份
## 权限chmod a+x Backup-web.sh
# 0 5 * * * /root/Backup-web.sh 每日凌晨5点执行备份

# 数据库认证
user="test"
password="123456"
host="localhost"
db_name="wp"

# 备份名
bak_name=WEB1

# 备份路径
backup_path_d="/root/_backup"

# 被备份路径
backup_path_s="/var/www/test.com/"

# 格式化日期类似：2019-07-22
date=$(date "+%Y-%m-%d")

# 设置导出文件的缺省权限
umask 177
# Dump数据库到SQL文件
/usr/bin/mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path_d/$db_name-$date.sql

sleep 20s
# 所有文件备份下来，并且保存其权限
/bin/tar -zcvpf $backup_path_d/$bak_name_$db_name-$date.tar $backup_path_s

# 删除30天之前的旧备份文件
find $backup_path_d/* -mtime +30 -exec rm {} \;
