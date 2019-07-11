### 因不常用，所以记下来

#### user.csv|格式：用户名拼音,显示名称,密码,姓,名,部门
```
ZhangSan,张三,0000,张,三,技术部
dataquery,资料查询,1111,资料,查询,上网机
```

#### 1.bat
```
REM 批量添加用户
for /f "tokens=1,2,3,4,5,6 delims=," %a in (user.csv) do dsadd user "cn=%b,OU=%f,OU=Mydepts,DC=test,DC=local" -samid %a -upn %a@test.local -fn %e -ln %d -pwd %c -display %b -dept %f -memberof "cn=%f,OU=Mysafes,DC=test,DC=local" -disabled no

REM 导出全部登录名
csvde -f list.csv -d "OU=depts,DC=test,DC=local" -l "SamAccountName"

REM 其它，userlist.csv|格式：liji,换行lili,换行lina,
for /f "tokens=1 delims=," %a in (userlist.csv) do net user %a|find "允许的工作站" >>允许的工作站.txt
for /f "tokens=1 delims=," %a in (userlist.csv) do net user %a|find "全名" >>全名.txt
for /f "tokens=1 delims=," %a in (userlist.csv) do net user %a|find "全局组成员" >>全局组成员.txt

REM 导出所有计算机
dsquery computer >computer20180518.txt

REM 备份全部组策略：
New-Item -Path C:\GPBak -ItemType Directory -Force
Backup-GPO -All -Path C:\GPBak -Comment "Weekly Bak" -Server MyS001.test.local

REM 还原全部组策略：
Restore-GPO -All -Path C:\GPBak -Server MyS001.test.local

REM 导出用户信息
Csvde -f bakUsers.Csv

REM 导入用户信息
Csvde -i -f bakUsers.Csv

REM 导出域信息，导出格式为：UserName,ComputerName
Clear
Import-CSV C:\1\uc.csv | % {
$UserN = $_.UserName
$ComputerN = $_.ComputerName
$ObjFilter = "(&(objectCategory=person)(objectCategory=User)(samaccountname=$UserN))"
$objSearch = New-Object System.DirectoryServices.DirectorySearcher
$objSearch.PageSize = 15000
$objSearch.Filter = $ObjFilter
$objSearch.SearchRoot = "LDAP://dc=test,dc=local"
$AllObj = $objSearch.findOne()
$user = [ADSI] $AllObj.path
$ErrorActionPreference = "silentlycontinue"
If (($user.get("userWorkstations")) -ne $null)
{$ComputerN = $user.get("userWorkstations")+","+ $ComputerN}
Write-host -NoNewLine "Updating $UserN Properties ..."
$user.psbase.invokeSet("userWorkstations",$ComputerN)
Write-host "Done!"
$user.setinfo() 
}

REM 添加OU
dsadd ou "ou=部门分类,DC=test,DC=local"
dsadd ou "ou=测试部,ou=部门分类,DC=test,DC=local"
dsadd ou "ou=安全分类,DC=test,DC=local"
dsadd group "cn=技术部,ou=安全分类,dc=test,dc=local"
```
