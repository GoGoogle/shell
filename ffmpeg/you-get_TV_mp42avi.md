### 前奏
  2020的春节因为[2019-nCoV](https://en.wikipedia.org/wiki/2019%E2%80%9320_Wuhan_coronavirus_outbreak)泛滥，导致假日无限期延长，终于，几年不怎么说话的发小在WeChat上找来了，说要下载电视剧给他爹看，因为是使用某山寨老版“移动DVD” 插上U盘播放，所以对格式（视频编码）的要求很坑爹，还停留在rmvb时代，幸亏里面有一些可以播放的视频文件，经过解析发现，video编码用的vxid，audio编码用的mp3，反正普通的MP4文件是不能播放的，只能播放xvid的AVI文件，这下可有事儿干了，坑货啊。

## 具体方案（分三步）

第一步：批量下载前奏，用了 Chrome 的一个叫 `Link Grabber` 的扩展搞定；
  
  批量复制播放链接到1.txt里面存起来，有个小细节，在iqiyi的电视剧介绍页面使用数字模式，然后用http而不是https，就可以筛选出所有的播放url了。
  
第二步：下载，下载现成的都很困难，我索性就使用了 iqiyi 的资源，`you-get` 干起；
  
  `you-get -I 1.txt --format=LD`
  
第三步：转码，当然是用王牌 `ffmpeg` 了。
  
  `for /R %v IN (*.mp4) do ( ffmpeg -i %v  -vcodec libxvid -acodec libmp3lame -f avi  "AVI\%~nv.avi")`
  
## 所用工具
  [Link Grabber](https://chrome.google.com/webstore/detail/link-grabber/caodelkhipncidmoebgbbeemedohcdma)
  [ffmpeg](https://www.ffmpeg.org/download.html)
  [you-get](https://github.com/soimort/you-get/)
  [python](https://python.org/)
  
### 后记
  这竟然是我2020年的第一篇Git，这些事情本来以前都做过，今天还是花了一两个小时研究，太耽误时间了，想想还是记下来吧。
