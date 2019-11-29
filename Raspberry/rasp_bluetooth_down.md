树梅派上用蓝牙播放音乐自动断开 填坑记录
=====

[TOC]

## 前言

> **设备：raspberrypi  3B+，蓝牙耳机，Kali系统**
>
> 这两天脑子发烧，想用它听歌，本身就是装了个kali，然后还把屏幕竖起来了；
> 把声音弄出来之后，开始连接蓝牙，各种折腾，终于能听了，感觉爽爽的；
> 结果没几分钟就不爽了，老子正听得爽的时候，它就断开连接了，虽开始折腾；
> 今天白天（2019.11.29）专门测试了一下，这蓝牙平常不会关，连耳机也不会自动关；
> 那么问题来了，这狗货怎么才能自动关闭？对！就是你听歌曲正爽的时候……艹

* 先看下蓝牙啥情况
```shell
$ hciconfig -a
hci0:   Type: Primary  Bus: UART
        BD Address: B8:27:EB:7A:53:01  ACL MTU: 1021:8  SCO MTU: 64:1
        DOWN
        RX bytes:283458 acl:274 sco:0 events:34212 errors:0
        TX bytes:57810866 acl:67863 sco:0 commands:206 errors:0
        Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH SNIFF
        Link mode: SLAVE ACCEPT
$ hciconfig hci0
hci0:   Type: Primary  Bus: UART
        BD Address: B8:27:EB:7A:53:01  ACL MTU: 1021:8  SCO MTU: 64:1
        DOWN
        RX bytes:283464 acl:274 sco:0 events:34212 errors:0
        TX bytes:57810890 acl:67863 sco:0 commands:212 errors:0
```
* DOWN掉了？
* 启用一下试试？
```shell
$ hciconfig hci0 up
Can't init device hci0: Connection timed out (110)
```
* ~~哇艹……怎么办~~

## 开始填坑


 #### 由于是Kali，我就顺着[Kali的方向](https://forums.kali.org/showthread.php?44451-Bluetooth-problem-with-Pi-Zero-W-Mac-address-AA-AA-AA-AA-AA-AA)找到了下面这句：

* 先备份，再替换
```shell
cp /lib/firmware/brcm/BCM43430A1.hcd ./
wget https://github.com/RPi-Distro/bluez-firmware/blob/master/broadcom/BCM43430A1.hcd -O /lib/firmware/brcm/BCM43430A1.hcd
```
* 我英文不怎么行，反正大概意思就是这芯片固件Bug之类的？

* **~~但最终还是不行~~**

* 反正Kali上的人说解决了，我这技能弱，没成功。

     

#### 既然Kali不行，那就找源头吧，找到这个玩意儿：

* [也是说修复了](https://github.com/raspberrypi/firmware/issues/860)
* 大概就是说 `/usr/bin/btuart` 这玩意儿不行，要换[别的脚本](https://drive.google.com/file/d/0B_P-i4u-SLBXRFZKOEFVU2xrcFE/view)，老套路，先备份，再编辑

    ```shell
    cp /usr/bin/btuart ./
    vim /usr/bin/btuart
    reboot
    ```
    
* 修复后的[btuart](https://drive.google.com/file/d/0B_P-i4u-SLBXRFZKOEFVU2xrcFE/view)版本代码：

    ```shell
    #!/bin/bash
    
    HCIATTACH=/usr/bin/hciattach
    SERIAL=`grep Serial /proc/cpuinfo | cut -c19-`
    B1=`echo $SERIAL | cut -c3-4`
    B2=`echo $SERIAL | cut -c5-6`
    B3=`echo $SERIAL | cut -c7-8`
    BDADDR=`printf b8:27:eb:%02x:%02x:%02x $((0x$B1 ^ 0xaa)) $((0x$B2 ^ 0xaa)) $((0x$B3 ^ 0xaa))`
    
    if [ "$(cat /proc/device-tree/aliases/uart0)" = "$(cat /proc/device-tree/aliases/serial1)" ] ; then
      if [ "$(wc -c /proc/device-tree/soc/gpio@7e200000/uart0_pins/brcm\,pins | cut -f 1 -d ' ')" = "16" ] ; then
        $HCIATTACH /dev/serial1 bcm43xx 3000000 flow - $BDADDR
      else
        $HCIATTACH /dev/serial1 bcm43xx 921600 noflow - $BDADDR
      fi
    else
      $HCIATTACH /dev/serial1 bcm43xx 460800 noflow - $BDADDR
    fi
    ```
* 老子 `reboot` 后以为修好了（因为坚持的时间很长），所以开始写这个笔记，结果笔记还没写完它又熄火了。现在有点慌了……


#### 继续摸，摸到了一个[官方方案](https://github.com/RPi-Distro/pi-bluetooth)

* 可惜了，我这是Kali，没有 `pi-bluetooth` 所以？我先想想……


#### 搬上官方说修复了的btuart
* 依葫芦画瓢，把 `pi-bluetooth` 的 `/usr/bin/btuart` [搬](https://github.com/RPi-Distro/pi-bluetooth/raw/master/usr/bin/btuart)过来了，还是不行。

    ```shell
    #!/bin/sh
    
    HCIATTACH=/usr/bin/hciattach
    if grep -q "Pi 4" /proc/device-tree/model; then
      BDADDR=
    else
      SERIAL=`cat /proc/device-tree/serial-number | cut -c9-`
      B1=`echo $SERIAL | cut -c3-4`
      B2=`echo $SERIAL | cut -c5-6`
      B3=`echo $SERIAL | cut -c7-8`
      BDADDR=`printf b8:27:eb:%02x:%02x:%02x $((0x$B1 ^ 0xaa)) $((0x$B2 ^ 0xaa)) $((0x$B3 ^ 0xaa))`
    fi
    
    uart0="`cat /proc/device-tree/aliases/uart0`"
    serial1="`cat /proc/device-tree/aliases/serial1`"
    
    if [ "$uart0" = "$serial1" ] ; then
            uart0_pins="`wc -c /proc/device-tree/soc/gpio@7e200000/uart0_pins/brcm\,pins | cut -f 1 -d ' '`"
            if [ "$uart0_pins" = "16" ] ; then
                    $HCIATTACH /dev/serial1 bcm43xx 3000000 flow - $BDADDR
            else
                    $HCIATTACH /dev/serial1 bcm43xx 921600 noflow - $BDADDR
            fi
    else
            $HCIATTACH /dev/serial1 bcm43xx 460800 noflow - $BDADDR
    fi
    ```
    
#### 应该是驱动有问题
* 自从发现这个btuart的东西很重要后，啥也不连接，直接restart这个服务试试
```shell
$ systemctl restart hciuart
Job for hciuart.service failed because the control process exited with error code.
See "systemctl status hciuart.service" and "journalctl -xe" for details.
$ tail /var/log/syslog -n10
Nov 30 00:27:48 BMWCTO systemd[1]: Starting Configure Bluetooth Modems connected by UART...
Nov 30 00:27:58 BMWCTO btuart[2534]: Initialization timed out.
Nov 30 00:27:58 BMWCTO btuart[2534]: bcm43xx_init
Nov 30 00:27:58 BMWCTO systemd[1]: hciuart.service: Control process exited, code=exited, status=1/FAILURE
Nov 30 00:27:58 BMWCTO systemd[1]: hciuart.service: Failed with result 'exit-code'.
Nov 30 00:27:58 BMWCTO systemd[1]: Failed to start Configure Bluetooth Modems connected by UART.
Nov 30 00:27:58 BMWCTO systemd[1]: hciuart.service: Service RestartSec=100ms expired, scheduling restart.
Nov 30 00:27:58 BMWCTO systemd[1]: hciuart.service: Scheduled restart job, restart counter is at 4.
Nov 30 00:27:58 BMWCTO systemd[1]: Stopped Configure Bluetooth Modems connected by UART.
Nov 30 00:27:58 BMWCTO systemd[1]: Starting Configure Bluetooth Modems connected by UART...
```
> 结果发现了什么？没错，它就是无法重启，又是timed out。
* 然后我单独测试了脚本里面的这句（转化所有变量后）
```shell
$ /usr/bin/hciattach /dev/serial1 bcm43xx 3000000 flow - b8:27:eb:7a:53:01
bcm43xx_init
Initialization timed out.
$ /usr/bin/hciattach /dev/serial1 bcm43xx 912600 noflow - b8:27:eb:7a:53:01
bcm43xx_init
Initialization timed out.
$ /usr/bin/hciattach /dev/serial1 bcm43xx 460800 noflow - b8:27:eb:7a:53:01
bcm43xx_init
Initialization timed out.
```
>无一例外，全都timed out了，这下应该有结论了，是蓝牙驱动（固件）有毛病。
>
>对，就是刚开始找的那些个 `BCM43430A1.hcd` 文件就是驱动，我 `cat` 看了一下，里面不是代码。
>
>这个坑算是填不上了，至此结束吧，累。

## 后记

#### 其它
  > 对，老子根本就没修好，那为什么会有这么个后记？
  > 小结：好好读书，英文啃起来比屎还难吃。

##### 把屏幕竖起来的代码

```shell
$ cat /boot/config.txt|head -n2`
display_rotate=3 #270
```

##### 用到的播放器是 sox 

> 默认还不识别mp3文件，坑。使用Ctrl+C切下一首，直到停止。

```shell
$ apt install -y sox libsox-fmt-mp3
$ cd music
$ play *.mp3
```

##### 猜测导致这个现象的可能性 

1. ~~连了SSH的原因~~ （对，笔记都还没写完，我也没连SSH，它又挂掉了）
2. 蓝牙电源自动关闭（类似Windows的电源管理？）
3. 内核固件（不知道是不是这么叫）有问题

##### 折磨强迫症患者

- 努力改掉CP备份时的坏习惯(名字也不改改，就扔在当前目录下)

- 时候不早了，要休息了，明天继续填，这些先记下来



####  A2DP出错解决方案：

> 如果安装了模块，但是 `pactl load-module module-bluetooth-discover`加载不了模块的话，需要手动修改一下配置。

1. 编辑 /etc/pulse/default.pa 文件。

   `vim /etc/pulse/default.pa`
   	

2. 找到 `load-module module-bluetooth-discover` 并在前面加#将它注释掉：

   `#load-module module-bluetooth-discover`
   	

3. 编辑 /usr/bin/start-pulseaudio-x11 文件

    `vim /usr/bin/start-pulseaudio-x11`
	
	找到下面的代码，并在它下面另其一行
    ```shell
    if [ x”$SESSION_MANAGER” != x ] ; then
         /usr/bin/pactl load-module module-x11-xsmp “display=$DISPLAY session_manager=$SESSION_MANAGER” > /dev/null
    fi
    ```

	在它下面写入(两个fi中间) `/usr/bin/pactl load-module module-bluetooth-discover` ，完整如下：
	```shell
	if [ x”$SESSION_MANAGER” != x ] ; then
		 /usr/bin/pactl load-module module-x11-xsmp “display=$DISPLAY session_manager=$SESSION_MANAGER” > /dev/null
	fi
		 /usr/bin/pactl load-module module-bluetooth-discover
	fi
	```
* 重启服务：
	
	```
	service bluetooth restart
	sudo pkill pulseaudio
	```
