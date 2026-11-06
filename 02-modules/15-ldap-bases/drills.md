# Drills — LDAP

## Drill 1 — Scopes base/one/sub (10 min)
- **Étapes** : même filtre `(objectClass=organizationalUnit)` avec les 3 scopes depuis la racine.
- **Observer** : le nombre de résultats change selon le scope.
- **Pourquoi** : maîtriser le périmètre d'une requête.

## Drill 2 — Filtres à bits (userAccountControl) (10 min)
- **Étapes** :
  ```powershell
  # Comptes sans pré-auth Kerberos (bit 0x400000)
  Get-ADUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=4194304)"
  ```
- **Observer** : la matching rule OID qui teste un bit.
- **Pourquoi** : c'est exactement ce que font les outils offensifs (AS-REP roasting).

## Drill 3 — Bind anonyme : autorisé ? (10 min)
- **Étapes** (Linux) : `ldapsearch -x -H ldap://10.10.0.10 -b "DC=corp,DC=meridian,DC=com" "(objectClass=user)"`.
- **Observer** : refus attendu (bien). Si ça répond, c'est une mauvaise config.

## Drill 4 — Capturer un bind non signé (15 min)
- **Étapes** : en lab, compare un bind simple sur 389 (clair) vs LDAPS 636 dans Wireshark.
- **Observer** : en 389 simple non chiffré, les données transitent lisibles.
- **Pourquoi** : justifier LDAPS + signature.

## Drill break-fix — Signature requise casse une vieille app (10 min)
- **Casse** : impose "Require signing" alors qu'un client simule un bind simple non signé.
- **Diagnostique** : le bind échoue (erreur de signature).
- **Répare** : passe le client en LDAPS/SASL ; comprends le compromis compatibilité/sécurité.
