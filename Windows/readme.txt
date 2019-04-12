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


## 把FFMPEG转码汇集成BAT文件：

@echo off
setlocal enabledelayedexpansion
mode con cols=100 lines=10
cd /d %~dp0
@echo.
@echo 先计算总码率
@echo.
set /p vt=视频总时长(秒)：
set /p vs=输出总大小(M)：
set /a vv=%vs%*1024*8/%vt%
@echo 视频总码率：%vv% kbps
pause
set "filename=00"
set /p filename=文件名(默认00)：
set "bv=1100"
set /p bv=输出视频码率(默认1100)：
set "ba=160"
set /p ba=输出音频码率(默认160)：
set "va=960"
set /p va=输出视频宽度(默认960)：
set "vb=540"
set /p vb=输出视频高度(默认540)：
set "t=30"
set /p t=等待多少秒执行(默认30秒)：
cls
@echo 请等待%t%秒（Ctrl+C可暂停或退出）...
choice /t %t% /d y /n >nul
ffmpeg -y -i %filename%.mp4 -c:v libx264 -preset medium -b:v %bv%k -s %va%x%vb% -pass 1 -c:a aac -b:a %ba%k -f mp4 NUL && ^ffmpeg -i %filename%.mp4 -c:v libx264 -preset medium -b:v %bv%k -s %va%x%vb% -pass 2 -c:a aac -b:a %ba%k out_%filename%.mp4
choice /t 3 /d y /n >nul
explorer %~dp0
