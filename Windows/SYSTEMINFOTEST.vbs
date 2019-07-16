'by BMWCTO 23:06 2017-3-16
'检测到计算机的主板,CPU(包括主频),内存,硬盘,显卡,网卡等相关信息
'特别适合在局域网内用来察看和管理内部计算机的硬件配置情况
'On Error Resume Next
temp = 0
Set wshshell = WScript.CreateObject("wscript.shell")
'启动WMI服务(没有这个服务就不行)
'wshshell.run ("%comspec% /c regsvr32 /s scrrun.dll"),0,True
'wshshell.run ("%comspec% /c sc config winmgmt start= auto"),0,True
'wshshell.run ("%comspec% /c net start winmgmt"),0
'用一个文本来记录硬件信息
Set WshNetwork = WScript.CreateObject("WScript.Network")
computername = WshNetwork.computername
Set fso = CreateObject("scripting.filesystemObject")
'tempfilter = computername & ".txt"
'这里是硬件信息纪录的存放位置,可以是网络共享路径(需有写入权限)
tempfilter = "\\10.0.0.2\computer$\"& computername & ".txt"

Set tempfile = fso.createtextfile(tempfilter)
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
'主板
Set board = objWMIService.ExecQuery("select * from win32_baseboard")
For Each Item In board
    board2=item.Manufacturer&" "&item.Product
Next

'BIOS日期
Function wDate(nD)
    If Not IsNull(nD) Then
    wDate = CDate(Mid(nD,5,2)&"/"&Mid(nD,7,2)&"/"&Left(nD,4)&" "&Mid(nD,9,2)&":"&Mid(nD,11,2)&":"&Mid(nD,13,2))
    End If
End Function
Set biostime = objWMIService.ExecQuery("select * from win32_Bios", , 48)
For Each Item In biostime
	biostime2= biostime2& FormatDateTime(wDate(item.ReleaseDate),1)
Next

'CPU
Set cpu = objWMIService.ExecQuery("select * from win32_processor")
For Each Item In cpu
    cpu2 =Item.Name
Next
'内存
Set colItems = objWMIService.ExecQuery("Select * from Win32_PhysicalMemory", , 48)
For Each objItem In colItems
    a = objItem.capacity
    temp = temp + a
    n = n + 1
Next
memory = a / 1048576
memoryb = Round(temp / 1048576 / 1024, 2)
If n = 1 Then
    memory2= n & "条" &memory&"M"
Else
    memory2= n & "条" &memory&"M"&" 总计:"&memoryb&"G"
End If
'硬盘
Set disk = objWMIService.ExecQuery("select * from win32_diskdrive")
For Each Item In disk
    disk2= disk2& item.Model&" "
Next
'系统版本
Set cOSs = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
For Each oOS in cOSs
        OSx = oOS.Caption &" " & oOS.CSDVersion
Next

'硬盘信息
'Dx= ""
Set IDE = objWMIService.ExecQuery("Select * from Win32_DiskDrive WHERE InterfaceType='IDE'")
Set cPPP = objWMIService.ExecQuery("SELECT * FROM Win32_PerfRawData_PerfDisk_PhysicalDisk")
For Each oIDE In IDE
    For i = 0 To IDE.Count
        Select Case oIDE.Index
            Case i
               For Each oPPP In cPPP
                   If InStr(oPPP.Name, i) Then vName = oPPP.Name
               Next
               Dx = Dx & "硬盘" & i &"型号:" & oIDE.Caption & ";" & "标称容量: "    & Round(oIDE.Size/1000000000) &" GB;"  
        End Select
    Next
Next

'显卡
Set video = objWMIService.ExecQuery("select * from win32_videocontroller", , 48)
For Each Item In video
    video2= video2& item.Description &" "
Next
'显示器
Set monitor = objWMIService.ExecQuery("select * from win32_DesktopMonitor", , 48)
For Each Item In monitor
	monitor3= monitor3& item.PNPDeviceID
	monitor4= monitor4& item.ScreenWidth
	monitor5= monitor5& item.ScreenHeight
Next
'网卡
Set colItems = objWMIService.ExecQuery("Select * from Win32_NetworkAdapter", , 48)
For Each objItem In colItems
    If (Left(objItem.NetConnectionID, 4) = "本地连接") Then
        lanname=lanname&objItem.Name
    End If
Next
lan2 = lanname
'   Set mc = GetObject("Winmgmts:").InstancesOf("Win32_NetworkAdapterConfiguration")
Set mc = objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration")
For Each mo In mc
    If mo.IPEnabled = True Then
        'TracePrint "本机网卡MAC地址是: " & mo.MacAddress
        getMAC = mo.MacAddress
        Exit For
    End If
Next
'Mac2="MAC 地址："& getMAC
Mac2=getMAC
'记录时间
systeminfotime= now

'当前用户
dim wsnet
set wsnet=wscript.createobject("wscript.network")
username2= wsnet.username

'msgbox board2 & chr(10)&chr(13) & cpu2 & chr(10)&chr(13) & memory2 & chr(10)&chr(13) & disk2 & chr(10)&chr(13) & video2 & chr(10)&chr(13) & lan2,0,"本机硬件信息"
'tempfile.write "计算机名："& computername &"|"
'tempfile.write (board2) &"|"
'tempfile.write (cpu2) &"|"
'tempfile.write (memory2) &"|"
'tempfile.write (disk2) &"|"
'tempfile.write (video2) &"|"
'tempfile.write (lan2) &"|"
'tempfile.write (Mac2) &"|"
'tempfile.write (systeminfotime)

tempfile.write computername &"|"
tempfile.write biostime2 &"|"
tempfile.write username2 &"|"
tempfile.write board2 &"|"
tempfile.write cpu2 &"|"
tempfile.write memory2 &"|"
'tempfile.write disk2 &"|"
tempfile.write Dx &"|"
tempfile.write video2 &"|"
tempfile.write monitor3 & ","& monitor4 &"×"& monitor5 &"|"
tempfile.write lan2 &"|"
tempfile.write Mac2 &"|"
tempfile.write OSx &"|"
tempfile.write systeminfotime
tempfile.writeline
'wshshell.run (computername & ".txt")
