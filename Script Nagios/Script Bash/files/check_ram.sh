#!/usr/bin/env bash
# check_ram.sh - Utilisation de la memoire vive
# Equivalent de Win32_OperatingSystem (TotalVisibleMemorySize / FreePhysicalMemory).

if [ ! -r /proc/meminfo ]; then
    echo "ERREUR: Impossible de lire la RAM"
    exit 3
fi

# Valeurs lues en Ko dans /proc/meminfo
total_kb=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
# MemAvailable = memoire reellement disponible pour les applications
# (preferable a MemFree sous Linux, qui exclut le cache et parait anormalement bas)
avail_kb=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)

if [ -z "$total_kb" ] || [ -z "$avail_kb" ] || [ "$total_kb" -eq 0 ]; then
    echo "ERREUR: Impossible de lire la RAM"
    exit 3
fi

used_kb=$((total_kb - avail_kb))

total=$(awk "BEGIN {printf \"%.2f\", $total_kb/1024}")
free=$(awk "BEGIN {printf \"%.2f\", $avail_kb/1024}")
used=$(awk "BEGIN {printf \"%.2f\", $used_kb/1024}")
percent=$(awk "BEGIN {printf \"%.0f\", ($used_kb/$total_kb)*100}")
free_percent=$(awk "BEGIN {printf \"%.0f\", 100-($used_kb/$total_kb)*100}")

echo "Memory usage: total:${total} MB - used: ${used} MB (${percent}%) - free: ${free} MB (${free_percent}%)"
exit 0
