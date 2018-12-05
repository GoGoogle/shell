#!/bin/sh
cd ~
get_now_str_time=`date "+%Y-%m-%d-%H-%M-%S"`
p_eavH="/home/bmwcto/soft/list"
mv $p_eavH/offline_update_eav.zip $p_eavH/eav_bak/eav_$get_now_str_time.zip
aria2c http://soft.ivanovo.ac.ru/updates/eset/offline_update_eav.zip --dir=$p_eavH --out=offline_update_eav.zip
sleep 2h;rm -rf $p_eavH/offline/*.*
sleep 10;unzip $p_eavH/offline_update_eav.zip -d $p_eavH/offline/
