$TimeLimit = (Get-Date).AddHours(-24)
$Errors = Get-EventLog -LogName System -After $TimeLimit -EntryType Error -ErrorAction SilentlyContinue
$Count = if ($Errors) { $Errors.Count } else { 0 }

if ($Count -eq 0) {
    Write-Host "LOGS OK : Aucune erreur detectee dans le journal Systeme"
    exit 0
    } else {
        Write-Host "LOGS WARNING: $Count erreur detectees dans le journal Systeme"
        exit 1
    }