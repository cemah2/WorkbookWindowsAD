# Attack — Compromission d'un RODC

> ⚠️ Lab isolé uniquement (voir LEGAL.md).

## Techniques
- **MITRE ATT&CK** : T1003 (Credential Dumping), T1078.
- **Principe** : un RODC volé n'expose que les secrets **mis en cache** (PRP).

## Déroulé (principe)
1. Vol/compromission physique du RODC d'agence.
2. Extraction des secrets **en cache** localement (comptes autorisés par la PRP).
3. Si la PRP est trop permissive (comptes sensibles en cache) → impact majeur ; sinon, limité aux
   comptes de l'agence.
4. Abus possible du krbtgt du RODC (portée limitée au périmètre du RODC).

## Ancrage réel
Le RODC existe précisément parce que les sites distants sont des cibles physiques. Une PRP mal
configurée a déjà transformé un « petit » RODC d'agence en point d'entrée vers des comptes sensibles.

## Résultat attendu
Comprendre que la sécurité d'un RODC = sa PRP. Durcissement dans `defend.md`.
