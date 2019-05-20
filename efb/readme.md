那么，我要总结一下我当前的版本信息：
```
ii  libwebp6:amd64                0.5.2-1
ii  libwebpmux2:amd64             0.5.2-1
ii  ffmpeg                        7:3.2.12-1~deb9u1
```
以上是动态库，以下是pip库（反正我是这么叫
```
efb-telegram-master==2.0.0b20
efb-wechat-slave==2.0.0a18
ehforwarderbot==2.0.0b15
python-telegram-bot==10.1.0
itchat==1.3.10
requests==2.22.0
urllib3==1.25.2
ffmpeg==1.4
imageio-ffmpeg==0.3.0
libmagic==1.0
Pillow==6.0.0
```
#中文文件名 #fixed #版本

```
dpkg -l|grep libwebp >>efb-All.txt
dpkg -l|grep ffmpeg>>efb-All.txt

pip3 freeze|grep efb >>efb-All.txt
pip3 freeze|grep ehforwarderbot>>efb-All.txt
pip3 freeze|grep python-telegram-bot >>efb-All.txt
pip3 freeze|grep itchat >>efb-All.txt
pip3 freeze|grep requests >>efb-All.txt
pip3 freeze|grep urllib3 >>efb-All.txt
pip3 freeze|grep ffmpeg >>efb-All.txt
pip3 freeze|grep libmagic >>efb-All.txt
pip3 freeze|grep Pillow>>efb-All.txt
```

```
pip3 uninstall requests
pip3 uninstall urllib3
pip3 uninstall python-telegram-bot
pip3 install requests==2.22.0
pip3 install urllib3==1.25.2
pip3 install python-telegram-bot==10.1.0
```
