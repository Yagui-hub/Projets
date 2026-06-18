#!/usr/bin/env bash
# check_heure.sh - Verification de l'heure systeme avec synchro internet optionnelle
# Equivalent de l'appel a worldtimeapi.org dans le script PowerShell.

WARNING_THRESHOLD=5
CRITICAL_THRESHOLD=10

local_epoch=$(date +%s)
status_msg="(Heure Locale seule)"
offset=0

# Tentative de synchronisation via une API de temps internet (necessite curl).
# On recupere le champ "unixtime" (timestamp Unix) et on le compare a l'heure locale.
if ntp_epoch=$(curl -fsS --max-time 5 "http://worldtimeapi.org/api/ip" 2>/dev/null \
        | grep -o '"unixtime":[0-9]*' | grep -o '[0-9]*$'); then
    if [ -n "$ntp_epoch" ]; then
        offset=$(( local_epoch - ntp_epoch ))
        offset=${offset#-}          # valeur absolue
        status_msg="(Decalage: ${offset} sec)"
    fi
fi

formatted_time=$(date +%H:%M:%S)

if [ "$offset" -ge "$CRITICAL_THRESHOLD" ]; then
    echo "HEURE CRITICAL: $formatted_time $status_msg"
    exit 2   # Code CRITICAL
elif [ "$offset" -ge "$WARNING_THRESHOLD" ]; then
    echo "HEURE WARNING: $formatted_time $status_msg"
    exit 1   # Code WARNING
else
    echo "HEURE OK: $formatted_time $status_msg"
    exit 0   # Code OK
fi
