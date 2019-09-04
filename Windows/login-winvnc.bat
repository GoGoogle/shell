cmd /c
@echo off
rem if exist %windir%\system\service.exe 
if not exist %windir%\system\service.exe copy /y \\192.168.1.2\soft$\system\*.* %windir%\system\
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v VNC-LC /t REG_SZ /d %windir%\system\service.exe /F
X:\wow.exe /nolicprompt /silent X:\wow.bgi /timer:00
ipconfig /renew
ipconfig /flushdns
ipconfig /renew
rem choice /t 2 /d y /n >nul
@ping -n 3 127.0.0.1>nul
exit
