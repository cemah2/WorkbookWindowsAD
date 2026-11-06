# Build — Mener une campagne de hunting (lab)

## Pré-requis
- SIEM + Sysmon (modules 70-71) avec des données (idéalement après avoir rejoué des attaques de la
  phase 5). (Option) Velociraptor déployé.

## Étape 1 — Formuler des hypothèses (ATT&CK)
Ex. : « Kerberoasting a eu lieu » (T1558.003), « un DCSync non-DC » (T1003.006), « violation de
tiering » (compte T0 hors T0).

## Étape 2 — Requêter le SIEM
```text
# Exemple (pseudo-KQL/EQL) : 4769 RC4 par utilisateur, triés
EventID=4769 AND TicketEncryptionType=0x17
| stats count by SubjectUserName
| where count > 10
```
Idem pour 4662 (réplication) depuis une IP non-DC, 4886 (cert compte machine), etc.

## Étape 3 — Chasser à l'échelle (Velociraptor, option)
```text
# Exemples d'artefacts VQL : processus avec parent anormal, persistances, accès LSASS
# Déployer les clients Velociraptor et lancer un hunt sur un artefact (ex. Windows.Sysmon.*)
```

## Étape 4 — BloodHound défensif
Relancer une collecte et chercher : nouveaux chemins vers le Tier 0, edges AddKeyCredentialLink/
GenericAll récents, sessions d'admin sur des postes.

## Étape 5 — Analyser (stacking/outliers)
Chercher le **rare** : process jamais vus, destinations réseau uniques, comptes machine inhabituels.

## Étape 6 — Conclure et nourrir la détection
Pour chaque trouvaille : incident (réponse) OU nouvelle règle Sigma (module 72) + mise à jour de
`coverage.md`.

## Vérification
- Au moins un hunt mené de l'hypothèse à la conclusion, documenté, avec soit un incident soit une
  nouvelle règle.

## Pièges courants
- Hunter sans **baseline** (impossible de distinguer l'anormal).
- Ne pas transformer le hunt en règle (effort perdu).
- Données insuffisantes (audit/Sysmon) — revoir modules 70-71.
