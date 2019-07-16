#### PowerShell 远程连接服务器

- 本地操作，添加信任：
```
Set-Item wsman:\localhost\Client\TrustedHosts -value 10.0.0.2
Set-Item wsman:\localhost\Client\TrustedHosts -value *
```

- 本地操作，清除信任：

`winrm delete winrm/config/listener?IPAdress=*+Transport=HTTP`

- 本地操作，远程连接10.0.0.2：
```
etsn 10.0.0.2 -Credential username
Enter-PSSession 10.0.0.2 -Credential test.local\administrator
```

- 远程操作，查找当前连接，默认端口5985：

`netstat -nao | findstr "5985"`

- 本地操作，添加远程用户名及密码后即可使用etsn 10.0.0.2直接连接：

`cmdkey /add:10.0.0.2 /user:test.local\administrator /pass:123456`

#### 有关历史记录

- 本地操作，查看命令历史记录：

`Get-Content (Get-PSReadlineOption).HistorySavePath`

- 本地操作，清除命令历史记录：

`Remove-Item (Get-PSReadlineOption).HistorySavePath`

- 所有powershell命令将会保存在固定位置:

`%appdata%\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt`

- 对于低版本的Powershell，如果命令中包含敏感信息(如远程连接的口令) 需要及时清除命令为：

`Clear-History`

- 对于cmd.exe，如果命令中包含敏感信息(如远程连接的口令) 需要及时清除命令为：

`doskey /reinstall`

- 查看命令为：

`doskey /h`

#### 查看启动时间

`wmic path Win32_OperatingSystem get LastBootUpTime`

`systeminfo`

#### 未测试
- 要清除屏幕显示历史记录（`F7`），您必须按 `ALT + F7`。
- 此历史记录由控制台缓冲区管理，而不是由其历史可清除的powershell管理 clear-history 小命令

- 编写脚本尝试：

```
[system.reflection.assembly]::loadwithpartialname("System.Windows.Forms")
[System.Windows.Forms.SendKeys]::Sendwait('%{F7 2}')
```


###### [参考](https://docs.microsoft.com/en-us/powershell/module/addsadministration/set-aduser?view=win10-ps)
[001.PDF.渗透技巧——获得Powershell命令的历史记录–3gstudent](./001.PDF.渗透技巧——获得Powershell命令的历史记录–3gstudent.pdf)
