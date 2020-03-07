## 路由器当AP和交换机使用，创建来宾网络，并隔离和限速

### 先改成交换机并当AP使用
  1. Network-Switch-VLANs 1中的WAN改成untagged,2中的WAN改成off；
  2. Network-Interfaces，删除所有WAN接口
  3. Network-Interfaces，把LAN（br-lan)的Protocol改成DHCP client；
  4. Network-Interfaces，防止连接不上OP，开个Alias网卡 @lan，添加一个新的interface，Protocol选择Static Address，填一个IP，例如192.168.1.1；

### 创建一个Guest连接点
  Network-Wireless,顺着[OpenWrt官方手册](https://openwrt.org/docs/guide-user/network/wifi/guestwifi/guestwifi_dumbap)就可以配置出一个带隔离主网络的SSID出来
### 只对Guest接口进行限速
  1. 安装[SQM](https://openwrt.org/docs/guide-user/network/traffic-shaping/sqm)，由于某些原因，只能离线安装，先去[下载](https://downloads.openwrt.org/releases/packages-19.07/mipsel_74kc/packages/)；
  2. 要下载两个.ipk `sqm-scripts_1.4.0-2_all.ipk` 和 `luci-app-sqm_1.4.0-2_all.ipk`；
  3. 然后通过本地http服务传入，这个比较简单，利用nginx等即可搞定；
  4. 安装完成后刷新web管理界面，在Network-SQM QOS即可找到；
  5. 然后对Guest接口进行限速，限速有个要注意的地方，对于网关来讲，上行是下行，下行是上行。
  6. 2000 (kbit/s) = 250KB/s
### 查找设备型号的指令集架构
  1. 例如4310，先去OP官方找到[tl-wdr4310设备页面](https://openwrt.org/toh/tp-link/tl-wdr4310)；
  2. 在Info信息中的Architecture栏有写，例如4310的架构是： `MIPS MIPS 74Kc`；
  3. 此信息在下载ipk的时候有用。
