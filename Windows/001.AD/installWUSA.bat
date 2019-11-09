@echo off&@setlocal enabledelayedexpansion

@REM 根据操作系统版本判断需要安装的补丁 2016年12月5日

ver | find "5.1." > NUL && goto win_xp
ver | find "5.2." > NUL && goto win2003
ver | find "6.1." > NUL && goto win7
ver | find "6.3." > NUL && goto win2012

:win_xp
for /f "tokens=1, 2, 3 delims=-/. " %%j in ('Date /T') do set FmTime=_%%j-%%k-%%l
for /f "tokens=1, 2 delims=: " %%j in ('TIME /T') do set FmTime=%FmTime%_%%j_%%k

@pushd \\10.0.0.1\SetupKB$
@echo ===================KB4.0 >>onlineUser.txt
@echo %FmTime%-%UserName% >>onlineUser.txt
rem kb4500331，先复制到本地，再进行安装（方式之一）
if not exist %SystemDrive%\00.KB md %SystemDrive%\00.KB
if not exist %SystemDrive%\00.KB\windowsxp-kb4500331-x86.exe copy windowsxp-kb4500331-x86.exe %SystemDrive%\00.KB\
sc config wuauserv start= demand
net start wuauserv
%SystemDrive%\00.KB\windowsxp-kb4500331-x86.exe /quiet /norestart
wmic qfe get hotfixid|find "KB4" >>onlineUser.txt
@echo ===================KB4.1 >>onlineUser.txt
@popd
goto end

:win7
@pushd \\10.0.0.1\SetupKB$
sc config wuauserv start= demand
net start wuauserv
wusa.exe windows6.1-kb4012212-x64.msu /quiet /norestart
@popd
goto end

:win2003
goto end

:win2012
goto end

rem 全部注释掉，用goto来进行段落注释，以免出现不必要的麻烦
goto end
rem 添加Hosts条目
:HostsAcl
echo y>y
cacls %windir%\system32\drivers\etc\hosts. /G everyone:f <y
echo 127.0.0.1	localhost>%windir%\system32\drivers\etc\hosts.
echo 10.0.0.1 ADdns.local >>%windir%\system32\drivers\etc\hosts.
echo y>y
cacls %windir%\system32\drivers\etc\hosts. /G everyone:r <y
goto end

rem DHCP自动获取
:AutoDhcp
netsh interface ip set address name="本地连接" source=dhcp
netsh interface ip set dns name="本地连接" source=dhcp
goto end

rem KB补丁
:win_xp-v1
if not exist %SystemDrive%\wcryKB md %SystemDrive%\wcryKB

rem kb4012598
if not exist %SystemDrive%\wcryKB\windowsxp-kb4012598-x86.exe copy \\10.0.0.1\SetupKB$\windowsxp-kb4012598-x86.exe %SystemDrive%\wcryKB\
Wusa.exe %SystemDrive%\wcryKB\windowsxp-kb4012598-x86.exe /quiet /norestart
rem Wusa.exe %SystemDrive%\wcryKB\WindowsXP-KB4012598-x86-Embedded-Custom-CHS.exe /quiet /norestart

rem kb4500331
if not exist %SystemDrive%\wcryKB\windowsxp-kb4500331-x86.exe copy \\10.0.0.1\SetupKB$\windowsxp-kb4500331-x86.exe %SystemDrive%\wcryKB\
Wusa.exe %SystemDrive%\wcryKB\windowsxp-kb4500331-x86.exe /quiet /norestart
goto end

rem reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v DisableUNCCheck /t REG_DWORD /d 1 /f

:end
rem 清除网络路径
@popd
exit
