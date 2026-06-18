$Uptime = (Get-Date) - ([Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject Win32_OperatingSystem).LastBootUptime))
Write-Host "System Uptime - $($Uptime.Days) day(s) $(Uptime.Hours) hour(s) $(Uptime.Minute) minute(s)"
exit 0