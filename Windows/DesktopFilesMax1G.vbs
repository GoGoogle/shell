Option Explicit
On Error Resume Next

Dim objFSO, objLocalFolder, longLocalFolderSize, strSizeMess,strDesktop,WshShell
Set objFSO = CreateObject("Scripting.FileSystemObject")
set WshShell = WScript.CreateObject("WScript.Shell") 
strDesktop = WshShell.SpecialFolders("Desktop")
Set objLocalFolder = objFSO.GetFolder(""& strDesktop &"")
longLocalFolderSize = objLocalFolder.Size
If longLocalFolderSize>=1024*1024*1024*1 Then
     strSizeMess = "当前桌面文件已经有"&Round( longLocalFolderSize/1024/1024/1024, 3 ) & "G之大请注意转移文件！"
     Else
      strSizeMess = WScript.Quit
End If
WScript.Echo strSizeMess
Set objFSO = Nothing
Set objLocalFolder = Nothing
WScript.Quit
