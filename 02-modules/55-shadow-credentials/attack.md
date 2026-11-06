# Attack — Shadow Credentials (lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1098 (Account Manipulation), T1649 (certs/PKINIT), T1556.
- **Outils** : certipy (shadow), Whisker/pywhisker, Rubeus, BloodHound.

## Déroulé
1. Recon : edge **AddKeyCredentialLink** vers une cible (DC/admin).
2. `certipy shadow auto` : ajoute une KeyCredential → PKINIT → TGT → **NT hash** de la cible.
3. Exploitation : DCSync (si DC) ou mouvement latéral (si admin).
4. Nettoyage : `certipy shadow clear`.

## Ancrage réel
Shadow Credentials (SpecterOps, 2021) est devenu une escalade/persistance de référence : discrète,
réversible, et fréquemment exploitable via une simple ACL mal placée.

## Résultat attendu
NT hash/TGT d'une cible obtenu via une écriture d'attribut → à neutraliser (`defend.md`).
