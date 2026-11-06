# Module 13 — Premier contrôleur de domaine (Phase 1)

Le jalon fondateur : passer d'un serveur préparé à un **domaine qui fonctionne**
(`corp.meridian.com`), à la main puis en PowerShell.

## Contenu
- `fiche.md` — AD DS, ce que la promotion installe (NTDS, SYSVOL, DNS, FSMO), DNS/SRV, versioning.
- `drills.md` — SRV, partitions (ADSI Edit), lecture de `dcdiag`, promotion automatisée, break-fix DNS.
- `build.md` — promotion pas-à-pas (GUI) + reconfiguration DNS + vérifications.
- `automate/` — `New-FirstDC.ps1` (promotion scriptée) + notes vers l'IaC.
- `attack.md` — ce qu'un DC tout neuf divulgue sans authentification (recon LDAP/SMB).
- `defend.md` — durcissement initial (signature LDAP/SMB, anonyme, SYSVOL) + détection.

## Definition of Done
- [ ] `corp.meridian.com` créé, `PAR-DC-01` promu (FL 2016), DNS intégré fonctionnel
- [ ] DNS client du DC sur lui-même + forwarder ; SRV `_ldap`/`_kerberos` résolus
- [ ] `dcdiag /v` sans erreur critique
- [ ] `New-FirstDC.ps1` rejoué sur VM jetable (manuel → automatisé)
- [ ] Drills faits (dont break-fix DNS) · recon anonyme comprise et réduite
- [ ] Mapping ATT&CK présent (T1087/T1482…) · ≥ 1 règle Sigma de détection
- [ ] Snapshot `dc-clean` pris avant le module 14 (objets AD)

## Prérequis / suite
Prérequis : module 10. Suite logique : `11-dns` (approfondir), puis `14-objets-ad`.
