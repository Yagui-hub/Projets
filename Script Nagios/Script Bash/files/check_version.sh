#!/usr/bin/env bash
# check_version.sh - Version de l'agent de supervision
# NSClient++ est l'agent Windows. Sous Linux, l'equivalent usuel est NRPE
# (Nagios Remote Plugin Executor). On verifie sa presence et sa version.

# Chemins habituels du binaire NRPE
NRPE_PATHS=(
    "/usr/sbin/nrpe"
    "/usr/local/nagios/bin/nrpe"
    "/usr/bin/nrpe"
)

nrpe_bin=""
for p in "${NRPE_PATHS[@]}"; do
    [ -x "$p" ] && nrpe_bin="$p" && break
done

# Repli : recherche dans le PATH
if [ -z "$nrpe_bin" ] && command -v nrpe >/dev/null 2>&1; then
    nrpe_bin=$(command -v nrpe)
fi

if [ -n "$nrpe_bin" ]; then
    # Extraction du numero de version depuis la sortie de "nrpe -V"
    version=$("$nrpe_bin" -V 2>&1 | grep -oiE 'v?[0-9]+\.[0-9]+(\.[0-9]+)?' | head -n1)
    [ -z "$version" ] && version="inconnue"
    # Date de derniere modification du binaire (equivalent LastWriteTime)
    date=$(date -r "$nrpe_bin" "+%Y-%m-%d" 2>/dev/null)
    echo "NRPE $version $date"
    exit 0
else
    echo "NRPE - Agent non trouve"
    exit 3
fi
