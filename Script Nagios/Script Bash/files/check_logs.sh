#!/usr/bin/env bash
# check_logs.sh - Erreurs systeme des dernieres 24h
# Equivalent du journal "System" Windows -> journal systemd (journalctl) sous Linux.

if command -v journalctl >/dev/null 2>&1; then
    # Messages de priorite "err" (et plus severes) sur les 24 dernieres heures
    count=$(journalctl --since "24 hours ago" -p err --no-pager -q 2>/dev/null | grep -c '.')
else
    # Repli sur les fichiers syslog si journalctl est absent
    count=0
    log_file=""
    for f in /var/log/syslog /var/log/messages; do
        [ -r "$f" ] && log_file="$f" && break
    done
    if [ -n "$log_file" ]; then
        count=$(grep -iE 'error|fail|critical' "$log_file" 2>/dev/null | grep -c '.')
    fi
fi

if [ "$count" -eq 0 ]; then
    echo "LOGS OK : Aucune erreur detectee dans le journal Systeme"
    exit 0
else
    echo "LOGS WARNING: $count erreur detectees dans le journal Systeme"
    exit 1
fi
