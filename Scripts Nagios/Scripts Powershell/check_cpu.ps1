$CPU = [Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
Write-Host "Charge CPU $CPU% (5 moyenne minimale)"
exit 0