### 防火墙相关命令设置

- @REM 导出规则

  `netsh advfirewall export "D:\Windows\firewall-bak\wf.pol"`

- @REM 导入规则

  `netsh advfirewall import "D:\Windows\firewall-bak\wf.pol"`

- @REM 恢复初始设置

  `netsh advfirewall reset`

- @REM 

  `netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound`
