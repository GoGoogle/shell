@echo off & setlocal EnableDelayedExpansion
@title 修改密码，0:29 2018/4/6
@mode con lines=20
@mode con cols=60
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
:uname
cls
set /p uname=1/3输入用户名(全拼)：
@echo.
if "%uname%"=="" echo    用户名呢？&@echo.&pause&goto uname
net user "%uname%" | find "上次"
@echo.
rem if /i "%uname%"=="Y" echo Over&pause&exit
rem echo 输入错误，请重试！
rem pause&goto uname

set "upass=Abc"
set /p upass=2/3输入新密码前缀(大小写至少2位，默认Abc): 
set "uupass=%upass%%random%"
cls 
color 0C
@echo.
@echo 【%uname%】的新密码为【%uupass%】,确认修改？！
@echo.&@echo 若不修改，请直接关闭！&pause&@echo.
net user %uname% %uupass%
@echo.
@echo 3/3，注意看提示成功了没有...&pause

rem 13:23 2019/3/4
