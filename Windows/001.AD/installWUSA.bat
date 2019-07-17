@echo off&@setlocal enabledelayedexpansion

@REM 根据操作系统版本判断需要安装的补丁 2016年12月5日
rem echo y>y
rem cacls %windir%\system32\drivers\etc\hosts. /G everyone:f <y
rem echo 127.0.0.1	localhost>%windir%\system32\drivers\etc\hosts.
rem echo 10.0.0.3 test.local AD.test.local TESTAD >>%windir%\system32\drivers\etc\hosts.
rem echo y>y
rem cacls %windir%\system32\drivers\etc\hosts. /G everyone:r <y
rem netsh interface ip set address name="本地连接" source=dhcp
rem netsh interface ip set dns name="本地连接" source=dhcp
rem wcryKB
rem \\10.0.0.2\com$\windowsxp-kb4012598-x86.exe /quiet /norestart
rem \\10.0.0.2\com$\WindowsXP-KB4012598-x86-Embedded-Custom-CHS.exe /quiet /norestart
rem ver | find "5.1." > NUL &&  goto win_xp
rem ver | find "6.1." > NUL &&  goto win7
rem :win_xp
rem if not exist %SystemDrive%\wcryKB md %SystemDrive%\wcryKB
rem if not exist %SystemDrive%\wcryKB\windowsxp-kb4012598-x86.exe copy \\10.0.0.2\com$\windowsxp-kb4012598-x86.exe %SystemDrive%\wcryKB\
rem %SystemDrive%\wcryKB\windowsxp-kb4012598-x86.exe /quiet /norestart
rem Wusa.exe \\10.0.0.2\com$\windowsxp-kb4012598-x86.exe /quiet /norestart
rem \\10.0.0.2\com$\windowsxp-kb4012598-x86.exe /quiet /norestart
rem goto end

cls
rem reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v DisableUNCCheck /t REG_DWORD /d 1 /f
ver | find "5.1." > NUL && goto win_xp
ver | find "6.1." > NUL && goto win7
ver | find "6.3." > NUL && goto win2012
:win7
@pushd \\10.0.0.2\com$
@REM 切换操作目录

sc wuauserv config start= demand
net start wuauserv
wusa.exe windows6.1-kb4012212-x64.msu /quiet /norestart

@popd
@REM 清除切换目录记录

goto end

:win_xp
goto end

:win2012
goto end

:end
@popd
@REM 清除切换目录记录
exit
