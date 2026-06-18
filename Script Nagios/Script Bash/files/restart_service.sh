#!/usr/bin/env bash
# restart_service.sh - Redemarrage d'un ou plusieurs services
# Equivalent de Restart-Service sous Windows -> systemctl sous Linux.
# Usage : ./restart_service.sh <service1> [service2] ...

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <nom_du_service> [autre_service ...]"
    exit 3
fi

for service in "$@"; do
    if error=$(systemctl restart "$service" 2>&1); then
        time=$(date)
        echo "Restarted service $service at $time"
    else
        echo "$error"
        exit 3
    fi
done
