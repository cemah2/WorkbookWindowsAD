# Build — Préparer le poste d'attaque & le lab offensif (GOAD-X)

> On met en place l'environnement offensif isolé et la discipline de travail (journal, reporting).

## Pré-requis
- GOAD déployé via Ludus (Phase 0 / `01-labs/goad-x/`). Poste attaquant Linux (Kali/Parrot).
- Réseau **strictement isolé** (VLAN 56, pas de route Internet/prod — module Phase 0).

## Étape 1 — Toolbox attaquant (versions figées)
```bash
pipx install impacket certipy-ad netexec
pipx install bloodhound-ce    # ou SharpHound côté Windows
sudo apt install -y nmap ldap-utils krb5-user   # ldapsearch, kinit
# Rubeus/Certify : binaires Windows à déposer sur une VM d'attaque Windows du lab
```
> Figer les versions (pip freeze / notes) pour la reproductibilité à 6 mois.

## Étape 2 — Snapshot « clean » du lab
Avant toute attaque, snapshot `clean-setup` (Ludus/Proxmox) pour rejouer depuis un état propre.

## Étape 3 — Configuration Kerberos (pour les outils -k)
`/etc/krb5.conf` (extrait) :
```
[libdefaults]
  default_realm = CORP.MERIDIAN.COM
[realms]
  CORP.MERIDIAN.COM = { kdc = 10.10.0.10 }
```
```bash
kinit jon.snow@CORP.MERIDIAN.COM   # obtenir un TGT pour les outils Kerberos
```

## Étape 4 — Journal de bord
Initialise `journal.md` (voir `automate/journal-template.md`) : date, action, commande, résultat,
Event IDs observés. C'est ce qui nourrira detection + rapport.

## Étape 5 — Point de départ "assumed breach"
Note le credential initial fourni (ex. `jon.snow`) et l'objectif (ex. Domain Admin / contrôle du DC).

## Vérification
```bash
nxc smb 10.10.0.10               # NetExec joint le DC
kinit jon.snow@CORP.MERIDIAN.COM && klist   # TGT obtenu
```

## Pièges courants
- Lab **non isolé** (danger + interdit hors lab).
- Horloge désynchronisée → outils Kerberos qui échouent (sync sur le DC).
- Ne pas journaliser → perte de la valeur pédagogique (détection/rapport).
