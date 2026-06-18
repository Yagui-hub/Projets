#!/usr/bin/env bash
# check_filesystem.sh - Utilisation du systeme de fichiers racine
# Equivalent du lecteur systeme C: sous Windows -> partition racine "/" sous Linux.

TARGET="/"

# Lecture en blocs de 1 Ko : utilise ($3) et disponible ($4)
read -r used_kb free_kb < <(df -Pk "$TARGET" | awk 'NR==2 {print $3, $4}')

# Total calcule comme utilise + libre (comme le script PowerShell d'origine)
total_kb=$((used_kb + free_kb))

total=$(awk "BEGIN {printf \"%.2f\", $total_kb/1024/1024}")
used=$(awk "BEGIN {printf \"%.2f\", $used_kb/1024/1024}")
free=$(awk "BEGIN {printf \"%.2f\", $free_kb/1024/1024}")
percent=$(awk "BEGIN {printf \"%.0f\", ($used_kb/$total_kb)*100}")
free_percent=$(awk "BEGIN {printf \"%.0f\", 100-($used_kb/$total_kb)*100}")

echo "/ - total: ${total} Gb - utilise : ${used} Gb (${percent}%) - libre ${free} Gb (${free_percent}%)"
exit 0
