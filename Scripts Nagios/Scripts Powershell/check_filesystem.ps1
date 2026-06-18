$Drive = Get-PSDrive C
$Used = [Math]::Round($Drive.Used / 1GB, 2)
$Free = [Math]::Round($Drive.Free / 1GB, 2)
$Total = $Used + $Free
$Percent = [Math]::Round(($Used / $Total) *100, 0)
Write-Host "c: - total: $Total Gb - utilise : $Used Gb ($Percent%) - libre $Free Gb ($([Math]::Round(100-$Percent,0))%)"
exit 0