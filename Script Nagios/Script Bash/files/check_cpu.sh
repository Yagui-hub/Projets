#!/usr/bin/env bash
# check_cpu.sh - Charge CPU instantanee
# Equivalent de Win32_Processor.LoadPercentage sous Windows.

# Premiere lecture des compteurs CPU agreges dans /proc/stat
read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
prev_idle=$((idle + iowait))
prev_total=$((user + nice + system + idle + iowait + irq + softirq + steal))

# Court intervalle de mesure
sleep 1

# Deuxieme lecture
read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
idle_now=$((idle + iowait))
total_now=$((user + nice + system + idle + iowait + irq + softirq + steal))

diff_idle=$((idle_now - prev_idle))
diff_total=$((total_now - prev_total))

if [ "$diff_total" -le 0 ]; then
    cpu=0
else
    # Pourcentage d'utilisation arrondi a l'entier le plus proche
    cpu=$(( (100 * (diff_total - diff_idle) + diff_total / 2) / diff_total ))
fi

echo "Charge CPU ${cpu}% (charge instantanee)"
exit 0
