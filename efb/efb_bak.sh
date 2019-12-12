#!/bin/bash
# 备份设置
# 0 4 * * * /root/efb_bak.sh 每日凌晨4点执行备份

backup_path_d="/root/_backup"
backup_path_s="/root/.ehforwarderbot/"
date=$(date "+%Y-%m-%d")
bak_name=EFB

sleep 10s

# 所有文件备份下来，并且保存其权限
/bin/tar -zcvpf $backup_path_d/$bak_name-$date.tar $backup_path_s

# 删除20天之前的旧备份文件
find $backup_path_d/$bak_name-*.tar -mtime +20 -exec rm {} \;
