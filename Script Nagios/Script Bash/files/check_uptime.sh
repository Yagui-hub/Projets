#!/usr/bin/env bash
# check_uptime.sh - Temps de fonctionnement du systeme
# Equivalent du calcul base sur LastBootUpTime sous Windows.

# Premier champ de /proc/uptime = secondes ecoulees depuis le demarrage
read -r uptime_seconds _ < /proc/uptime
uptime_seconds=${uptime_seconds%.*}     # on ne garde que la partie entiere

days=$(( uptime_seconds / 86400 ))
hours=$(( (uptime_seconds % 86400) / 3600 ))
minutes=$(( (uptime_seconds % 3600) / 60 ))

echo "System Uptime - ${days} day(s) ${hours} hour(s) ${minutes} minute(s)"
exit 0
