# AD的一些日常操作（命令行）

- 添加用户  
    `for /f "tokens=1,2,3,4,5,6 delims=," %a in (users.csv) do dsadd user "cn=%b,OU=%f,OU=XXdepts,DC=local,DC=XXX" -samid %a -upn %a@local.XXX -fn %e -ln %d -pwd %c -display %b -dept %f -memberof "cn=%f,OU=XXsafes,DC=local,DC=XXX" -disabled no`

- users.csv  

    ```csv
    maxiaojian,马小贱,1234,马,小贱,事业部
    wangling,王玲,5678,王,玲,车间
    XXgonggong,XX公共,8888,XX,公共,XX公司
    ```

- 备份全部组策略(PowerShell)  

    ```powershell
    New-Item -Path C:\GPBak -ItemType Directory -Force
    Backup-GPO -All -Path C:\GPBak -Comment "Weekly Bak" -Server WQS001.local.XXX
    ```

- 还原全部组策略(PowerShell)  
    `Restore-GPO -All -Path C:\GPBak -Server WQS001.local.XXX`
