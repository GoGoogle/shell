@echo off & setlocal EnableDelayedExpansion
@title DelMySelf，11:10 2018/4/17
@rem 清空跑路系列 by 17:36 2018/5/4
@mode con lines=20
@mode con cols=60
cls

REM 设置被压缩后删除的目录
set "a1=C:\EFI"
set "d1=C:\Users\Administrator\Desktop\L*.lnk"

REM 格式化时间并设置为文件名变量
set hour=%time:~,2%
if "%time:~,1%"==" " set hour=0%time:~1,1%
set tname=%date:~0,4%%date:~5,2%%date:~8,2%%hour%%time:~3,2%%time:~6,2%

REM 利用RAR.exe压缩并加密后清空
%a1%\rar.exe M -P密码 %a1%\L.%tname%_A.rar %d1% %a1%\2

REM 打开目录
explorer %a1%

REM 删除自身
Del /Q %0 >Nul
