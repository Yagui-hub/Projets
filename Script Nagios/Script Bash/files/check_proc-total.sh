#!/usr/bin/env bash
# check_proc-total.sh - Nombre total de processus
# Equivalent de (Get-Process).Count sous Windows.

count=$(ps -e --no-headers | wc -l)
echo "SNMP OK - $count"
exit 0
