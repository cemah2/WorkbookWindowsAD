#!/usr/bin/env bash
# Enumération AD de base (lab isolé GOAD-X uniquement). NE PAS utiliser hors autorisation.
set -euo pipefail
DOMAIN="${1:?domaine}"; DC="${2:?ip dc}"; USER="${3:?user}"; PASS="${4:?pass}"
OUT="recon-$(date +%Y%m%d-%H%M%S)"; mkdir -p "$OUT"; cd "$OUT"
echo "[*] Users/groups/shares (NetExec)..."
nxc smb "$DC" -u "$USER" -p "$PASS" --users   | tee users.txt
nxc smb "$DC" -u "$USER" -p "$PASS" --groups  | tee groups.txt
nxc smb "$DC" -u "$USER" -p "$PASS" --pass-pol | tee passpol.txt
echo "[*] BloodHound (CE collector)..."
bloodhound-python -u "$USER" -p "$PASS" -d "$DOMAIN" -ns "$DC" -c All --zip || \
  echo "  (installer bloodhound-python / vérifier DNS)"
echo "[*] Terminé -> $OUT"
