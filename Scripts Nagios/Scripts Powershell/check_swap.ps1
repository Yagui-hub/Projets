$Swap = Get-WmiObject Win32_PageFileUsage
if ($Swap -eq $null) {
Write-Host "SWAP OK - Aucun fichier d'échange configure"
exit 0
}
$Total = $Swap.AllocatedBaseSize
$Used = $Swap.CurrentUsage
$Percent = [Math]::Round(($Used / $Total) * 100, 0)
$Free = $Total - $Used

Write-Host "SWAP OK - total: $Total MB - utilise: $Used MB ($Percent%) -libre: $Free MB"
exit 0