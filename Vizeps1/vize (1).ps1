﻿$Processes = @{}
Get-Process -IncludeUserName | ForEach-Object {
    $Processes[$_.Id] = $_
}


Get-NetTCPConnection | 
    Where-Object { $_.LocalAddress -eq "0.0.0.0" -and $_.State -eq "Listen" } |
    Select-Object LocalAddress,
        LocalPort,
        @{Name="PID";         Expression={ $_.OwningProcess }},
        @{Name="UserName";    Expression={ $Processes[[int]$_.OwningProcess].UserName }},
        @{Name="ProcessName"; Expression={ $Processes[[int]$_.OwningProcess].ProcessName }}, 
        @{Name="Path"; Expression={ $Processes[[int]$_.OwningProcess].Path }} |
    Sort-Object -Property LocalPort, UserName |
  Format-Table -AutoSize | Out-File C:\Users\SELCUK\Desktop\Vizeps1\proces.txt -Encoding utf8




Get-NetUDPEndpoint | 
    Where-Object { $_.LocalAddress -eq "0.0.0.0" } |
    Select-Object LocalAddress,
        LocalPort,
        @{Name="PID";         Expression={ $_.OwningProcess }},
        @{Name="UserName";    Expression={ $Processes[[int]$_.OwningProcess].UserName }},
        @{Name="ProcessName"; Expression={ $Processes[[int]$_.OwningProcess].ProcessName }}, 
        @{Name="Path"; Expression={ $Processes[[int]$_.OwningProcess].Path }} |
    Sort-Object -Property LocalPort, UserName |
    Format-Table -AutoSize | Out-File C:\Users\SELCUK\Desktop\Vizeps1\proces.txt -Encoding utf8

