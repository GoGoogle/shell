##更改时区：
tzselect

##设置时区：
TZ='Asia/Shanghai'; export TZ
或扔
vim ~/.bashrc
export TZ='Asia/Shanghai'

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

##重启
sudo reboot

##安装Kodi
sudo apt update
sudo apt install kodi
sudo apt install kodi-peripheral-joystick kodi-pvr-iptvsimple kodi-inputstream-adaptive kodi-inputstream-rtmp
sudo tee -a /lib/systemd/system/kodi.service <<_EOF_
[Unit]
Description = Kodi Media Center
After = remote-fs.target network-online.target
Wants = network-online.target

[Service]
User = pi
Group = pi
Type = simple
ExecStart = /usr/bin/kodi
Restart = on-abort
RestartSec = 5

[Install]
WantedBy = multi-user.target
_EOF_

sudo service kodi start


##修改音频输出
amixer cset numid=3 2
这里将输出设置为2，也就是HDMI。
将输出设置为1将切换到模拟信号（也就是耳机接口）。
默认的设置为0，代表自动选择。

##安装Python3.7.2
sudo apt-get update -y
sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y
wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tar.xz
tar xf Python-3.7.2.tar.xz
cd Python-3.7.2
./configure
make -j 4
sudo make altinstall
cd ..
sudo rm -r Python-3.7.2
rm Python-3.7.2.tar.xz
sudo apt-get --purge remove build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y
sudo apt-get autoremove -y
sudo apt-get clean

##挂载移动硬盘
// 硬盘接入USB口后，系统不会自动挂载，查看已连接的储存设备
sudo fdisk-l
// 找到我们所需设备的名称(sda1)，格式化为ext4
sudo mkfs.ext4 /dev/sda1

// 命令查看硬件设备，并找到我们所需设备的名称。
sudo fdisk -l

// 新建一个挂载目录文件夹
sudo mkdir /media/piusb/
// 将设备的分区挂载到该目录上面
sudo mount /dev/sda1 /media/piusb
// 这时就已经挂载好了，也可以用以下命令查看挂载情况：
df-h


// 安装 nfts 支持
sudo apt-get install -y ntfs-3g
// 加载内核支持
modprobe fuse

// 查看要指定加载储存设备的UUID
sudo blkid

// 编辑设备管理
sudo vim /etc/fstab
// 在最后一行添加你要挂载的设备
// 针对非 ntfs 格式的移动硬盘
UUID=3EFBF3DF518ACC17 /media/piusb auto defaults,noexec,umask=0000 0 0

// 针对 ntfs 格式的移动硬盘，外部设备在插入时挂载，在未插入时忽略。这需要 nofail 选项，可以在启动时若设备不存在直接忽略它而不报错.
UUID=927E8B977E8B72B1 /media/piusb1 ntfs-3g defaults,nofail,umask=0000 0 0
UUID=5E20C27E20C25D21 /media/piusb2 ntfs-3g defaults,nofail,umask=0000 0 0




##自动挂载SMB共享
sudo nano /etc/fstab
//192.168.X.X/share /home/pi/share cifs username=XXX,password=XXX,vers=1.0 0 0
重启或键入
sudo mount -a


卸载已挂载的存储设备
sudo umount /media/usb
