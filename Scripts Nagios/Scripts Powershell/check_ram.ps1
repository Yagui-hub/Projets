try {
$Computer = Get-WmiObject -Class Win32_OperatingSystem -ErrorAction Stop
$Total = [Math]::Round($Computer.TotalVisibleMemorySize / 1KB, 2)
$Free = [Math]::Round($Computer.FreePhysicalMemory / 1KB, 2)
$Used = $Total - $Free
$Percent = [Math]::Round(($Used / $Total) * 100, 0)
Write-Host "Memory usage: total:$Total MB - used: $Used MB ($Percent%) - free: $Free MB ($([Math]::Round(100-$Percent,0))%)"
exit 0
} catch {
   Write-Host "ERREUR: Impossible de lire la RAM"
   exit 3
}