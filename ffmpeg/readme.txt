#FFMPEG
##提取音频
ffmpeg -i sample.avi -q:a 0 -map a sample.mp3

##快速视频剪辑
#从54分55秒开始后120秒内容
ffmpeg -ss 00:54:55 -i in.mp4 -t 120 -vcodec copy -acodec copy out.mp4

#从1分05秒开始后120秒内容
ffmpeg -ss 65s -t 120 -accurate_seek -i in.mp4 -codec copy out.mp4

ffmpeg -ss [start] -t [duration] -accurate_seek -i [in].mp4 -codec copy  -avoid_negative_ts 1 [out].mp4

##剪辑并重新编码
ffmpeg -ss [start] -t [duration] -i [in].mp4  -c:v libx264 -c:a aac -strict experimental -b:a 98k [out].mp4
[start]:为需要截取内容的开始时间
[duration]:为需要截取的时长
[in]:为输入视频文件名
[out]:为输出视频文件名



##压缩视频
时长650秒。现在想把它转成一个25MB的文件

目标文件的整体比特率：25 x 1024 x 8 / 650= 315 kbps
设置音频流比特率为：32 kbps
视频的则为：315 kbps-32 kbps=283K，约280K

新的视频文件分辨率为：640x360

二次转码公式为：
ffmpeg -y -i in.mp4 -c:v libx264 -preset medium -b:v 280k -s 640x360 -pass 1 -c:a aac -b:a 32k -f mp4 NUL && ^ffmpeg -i in.mp4 -c:v libx264 -preset medium -b:v 280k -s 640x360 -pass 2 -c:a aac -b:a 32k out.mp4
