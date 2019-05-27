那么，我要总结一下我当前的版本信息：
```
ii  libwebp6:amd64                0.5.2-1
ii  libwebpmux2:amd64             0.5.2-1
ii  ffmpeg                        7:3.2.12-1~deb9u1
```
以上是动态链接库，以下是pip库
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

**批量卸载/安装**

`
pip3 uninstall -r efb-unpip.txt
`

efb-unpip.txt:

```
requests
urllib3
python-telegram-bot
```
`
pip3 install -r efb-pip.txt
`

efb-pip.txt:

```
requests==2.22.0
urllib3==1.25.2
python-telegram-bot==10.1.0
```


修复快速同时发两个或多个文件，TG收到同样的重复文件的问题

[ews#30](https://github.com/blueset/efb-wechat-slave/issues/30)

[Mark1](https://t.me/c/1083959736/53784)

[Mark2](https://t.me/c/1083959736/53818)
```
$ sed -n '142,172p' /usr/Py373/lib/python3.7/site-packages/itchat/components/messages.py
                'Text': download_video, }
        elif m['MsgType'] == 49: # sharing
            if m['AppMsgType'] == 6:
                rawMsg = m
                cookiesList = {name:data for name,data in core.s.cookies.items()}
                    url = core.loginInfo['fileUrl'] + '/webwxgetmedia'
                    params = {
                        'sender': rawMsg['FromUserName'],
                        'mediaid': rawMsg['MediaId'],
                        'filename': rawMsg['FileName'],
                        'fromuser': core.loginInfo['wxuin'],
                        'pass_ticket': 'undefined',
                        'webwx_data_ticket': cookiesList['webwx_data_ticket'],}
                    headers = { 'User-Agent' : config.USER_AGENT }
                def download_atta(attaDir=None):
                    r = core.s.get(url, params=params, stream=True, headers=headers)
                    tempStorage = io.BytesIO()
                    for block in r.iter_content(1024):
                        tempStorage.write(block)
                    if attaDir is None:
                        return tempStorage.getvalue()
                    with open(attaDir, 'wb') as f:
                        f.write(tempStorage.getvalue())
                    return ReturnValue({'BaseResponse': {
                        'ErrMsg': 'Successfully downloaded',
                        'Ret': 0, }})
                msg = {
                    'Type': 'Attachment',
                    'Text': download_atta, }
            elif m['AppMsgType'] == 8:
                download_fn = get_download_fn(core,
```
