# TLS1.2 pour la connexion internet
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$WarningThreshold = 5
$CriticalThreshold = 10
$LocalTime = Get-Date 

try {
# Tentative de la synchro internet
$NTPTime = (Invoke-RestMethod -Uri "http://worldtimeapi.org/api/ip").datetime
$ReferenceTime = [DateTime]::Parse($NTPTime)
$Offset = [Math]::Abs(($LocalTime - $ReferenceTime).TotalSeconds)
$OffsetRounded = [Math]::Round($Offset, 2)
$StatusMsg = "(Decalage: $OffsetRounded sec)"
} catch {
# Si internet echoue, on reste en OK sur l'heure locale sans erreur 
$Offset = 0
$StatusMsg = "(Heure Locale seule)"
}


$FormattedTime = $LocalTime.ToString("HH:mm:ss")
 
if ($Offset -ge $CriticalThreshold) {
    Write-Host "HEURE CRITICAL: $FormattedTime $StatusMsg"
    exit 2 # Code CRITICAL 
}
elseif ($Offset -ge $WarningThreshold) {
    Write-Host "HEURE WARNING: $FormattedTime $StatusMsg"
    exit 1 # Code WARNING
}
else {
    Write-Host "HEURE OK: $FormattedTime $StatusMsg"
    exit 0 # Code OK
}