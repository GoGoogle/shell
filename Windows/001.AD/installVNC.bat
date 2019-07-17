@REM 批量复制，安装VNC 2016年12月3日
cmd /c
@echo off
rem if exist %windir%\system\service.exe 
if not exist %windir%\system\service.exe copy /y \\10.0.0.3\soft$\system\*.* %windir%\system\
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v VNC-LC /t REG_SZ /d %windir%\system\service.exe /F
X:\wow.exe /nolicprompt /silent X:\wow.bgi /timer:00
ipconfig /renew
ipconfig /flushdns
ipconfig /renew
rem choice /t 2 /d y /n >nul
@ping -n 3 127.0.0.1>nul
exit
