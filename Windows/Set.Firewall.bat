@echo off&@setlocal enabledelayedexpansion
@echo off&title 修改防火墙 Ver 1.0 【 by：BMWCTO 14:01 2019/6/30】&mode con: cols=99 lines=36 & color 9f

@REM 判断是否为管理员权限执行的本程序

Rem 创建文件路径
set TempFile_Name=%SystemRoot%\System32\BatTestUACin_SysRt%Random%.batemp
rem echo %TempFile_Name%
 
Rem 写入文件
( echo "BAT Test UAC in Temp" >%TempFile_Name% ) 1>nul 2>nul
 
Rem 判断写入是否成功
if exist %TempFile_Name% (
goto fixupass
) else (
echo.
echo 请确认以右键单击“以管理员身份运行”的本程序...&echo "如杀毒软件提示，点击允许。"&echo.&pause&exit
)
pause

:fixupass
Rem 删除临时文件
del %TempFile_Name% 1>nul 2>nul

:loop
CLS
echo     ※※※※※※※※※※※※※※※※※※※※※※※※※※※※
echo     ※                                                    ※
echo     ※      修改防火墙 by BMWCTO
echo     ※      lastupdate:%~t0
echo     ※
echo     ※注意：先去WF.msc(高级防火墙)手动创建规则
echo     ※
echo     ※      请先选择规则
echo     ※
echo     ※      「1」- 00.SMB
echo     ※
echo     ※      「2」- 01.NFS
echo     ※
echo     ※      「e」- 编辑程序
echo     ※
echo     ※      「q」- 退出程序
echo     ※                                                    ※
echo     ※※※※※※※※※※※※※※※※※※※※※※※※※※※※
choice /c:12eq /n
if %errorlevel% equ 1 goto smb
if %errorlevel% equ 2 goto nfs
if %errorlevel% equ 3 goto editme
if %errorlevel% equ 4 exit

:smb
set RULE_NAME="00.SMB"
goto loop2

:nfs
set RULE_NAME="01.NFS"
goto loop2

:editme
choice /t 1 /d y /n >nul
notepad.exe "%~f0"
pause
goto loop

:loop2
set RULE_IP1=192.168.1.22
set RULE_IP2=192.168.1.99-192.168.1.100,10.0.0.3
set RULE_IP3=10.0.1.2-10.0.1.30
CLS
echo     ※※※※※※※※※※※※※※※※※※※※※※※※※※※※
echo     ※                                                    ※
echo     ※
echo     ※      「q」- 退出程序
echo     ※
echo     ※      「1」- 娱乐
echo     ※
echo     ※      「2」- 办公楼
echo     ※
echo     ※      「3」- 住宅区
echo     ※
echo     ※      「s」- 手动设置
echo     ※
echo     ※      「a」- 查看设置
echo     ※                                                    ※
echo     ※※※※※※※※※※※※※※※※※※※※※※※※※※※※

choice /c:123qsa /n
if %errorlevel% equ 1 goto ip1
if %errorlevel% equ 2 goto ip2
if %errorlevel% equ 3 goto ip3
if %errorlevel% equ 4 exit
if %errorlevel% equ 5 goto setip
if %errorlevel% equ 6 goto showset

rem set /p RULE_IP2=请输入IP地址:

:ip1
set RULE_REMOTEIP="%RULE_IP1%"
echo %RULE_REMOTEIP%
goto setRule

:ip2
set RULE_REMOTEIP="%RULE_IP2%"
echo %RULE_REMOTEIP%
goto setRule

:ip3
set RULE_REMOTEIP="%RULE_IP3%"
echo %RULE_REMOTEIP%
goto setRule

:setip
set RULE_REMOTEIP=localsubnet
set /p RULE_REMOTEIP=请输入IP地址(any):
echo %RULE_REMOTEIP%
goto setRule
:setRule
netsh advfirewall firewall set rule name=%RULE_NAME% new remoteip=%RULE_REMOTEIP%
rem 给本身最后一行写入修改时间的批注
echo rem %~t0>>"%~f0"
goto showset
:showset
@echo.
echo     ※※※※※※※※※※※※※※※※※※※※※※※※※※※※
netsh advfirewall firewall show rule name=%RULE_NAME%
pause
goto loop

pause
rem 2019/06/30 14:10
rem 2019/06/30 14:44
rem 2019/07/05 10:50
rem 2019/07/06 01:49
rem 2019/07/08 18:21
rem 2019/07/12 10:55
rem 2019/07/16 10:47
