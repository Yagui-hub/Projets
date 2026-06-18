#!/usr/bin/env bash
# check_swap.sh - Utilisation du swap
# Equivalent de Win32_PageFileUsage (fichier d'echange) sous Windows.

total_kb=$(awk '/^SwapTotal:/ {print $2}' /proc/meminfo)
free_kb=$(awk '/^SwapFree:/ {print $2}' /proc/meminfo)

# Aucun swap configure
if [ -z "$total_kb" ] || [ "$total_kb" -eq 0 ]; then
    echo "SWAP OK - Aucun fichier d'echange configure"
    exit 0
fi

used_kb=$((total_kb - free_kb))

total=$(awk "BEGIN {printf \"%.0f\", $total_kb/1024}")
used=$(awk "BEGIN {printf \"%.0f\", $used_kb/1024}")
free=$(awk "BEGIN {printf \"%.0f\", $free_kb/1024}")
percent=$(awk "BEGIN {printf \"%.0f\", ($used_kb/$total_kb)*100}")

echo "SWAP OK - total: ${total} MB - utilise: ${used} MB (${percent}%) -libre: ${free} MB"
exit 0
