##没想到也会记Windows的
##老了，记忆力不行（其实从来都没记住过……

@rem BAT延时处理示例
cd /d I:\Downloads
@echo off
choice /t 10 /d y /n >nul
@echo 10s
@ping 127.0.0.1 -n 15 >nul
@echo 15s
choice /t 5 /d y /n >nul
@echo 5s

@REM FFMPEG转码的时候懒得等了，想睡觉去了（真没想到能这么慢……
@REM 多线程的话太慢，所以就这么处理了。
cd /d I:\Downloads
@echo off
choice /t 3000 /d y /n >nul
ffmpeg -y -i 04.mp4 -c:v libx264 -preset medium -b:v 1100k -s 960x540 -pass 1 -c:a aac -b:a 160k -f mp4 NUL && ^ffmpeg -i 04.mp4 -c:v libx264 -preset medium -b:v 1100k -s 960x540 -pass 2 -c:a aac -b:a 160k EP04.mp4
choice /t 10 /d y /n >nul
ffmpeg -y -i 06.mp4 -c:v libx264 -preset medium -b:v 1100k -s 960x540 -pass 1 -c:a aac -b:a 160k -f mp4 NUL && ^ffmpeg -i 06.mp4 -c:v libx264 -preset medium -b:v 1100k -s 960x540 -pass 2 -c:a aac -b:a 160k EP06.mp4
