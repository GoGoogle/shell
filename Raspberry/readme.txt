##更改时区：
tzselect

##设置时区：
TZ='Asia/Shanghai'; export TZ

##安装同步：
sudo apt-get install ntpdate

##同步时间：
sudo ntpdate cn.pool.ntp.org

##配置：
sudo raspi-config

##扫描Wifi：
sudo iwlist wlan0 scan

##配置Wifi信息：
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=CN

network={
    ssid="1234"
    priority=1
    scan_ssid=1
    key_mgmt=NONE
}

network={
    ssid="4321"
    psk="123546789"
    priority=2
    id_str="Home"
}
CTRL+O保存
CTRL+X退出

#ssid:网络ssid
#psk:网络密码
#priority:连接优先级，数字越大优先级越高（不可以是负数）
#scan_ssid:连接隐藏WiFi时需要指定该值为1
#key_mgmt:如果没有密码，需要指定key_mgmt为NONE
#country:设置国家代码，方便选择无线频段
