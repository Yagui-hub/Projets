$nscpPath = "C:\Program Files\NSClient++\nscp.exe"

if (Test-Path $nscpPath) {
$version = (Get-Item $nscpPath).VersionInfo.FileVersion
$date = (Get-Item $nscpPath).LastWriteTime.ToString("yyyy-MM-dd")
Write-Host "NSClient++ $version $date"
exit 0 
} else { 
    Write-Host "NSClient++ - Agent non trouvé"
    exit 3
}