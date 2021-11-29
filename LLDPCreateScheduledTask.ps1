$TaskName = 'LLDP PowerShell Script'
$TaskDescription = 'Version 1.0.0'
$Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-ExecutionPolicy bypass -NonInteractive -NoLogo -NoProfile -File "C:\Temp\LLDP.ps1"'
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddSeconds(15) -RepetitionInterval (New-TimeSpan -Minutes 30)
$Settings = New-ScheduledTaskSettingsSet
$Principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest 
Get-ScheduledTask -TaskName $TaskName
Unregister-ScheduledTask -TaskName  $TaskName | Out-Null
Register-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings -TaskName $TaskName -Description $TaskDescription | Out-Null
