# Attack — Secrets LSASS & DPAPI (compréhension défensive)

> ⚠️ Lab isolé. L'extraction concrète est au module 56 ; ici le « pourquoi » interne, pour détecter.

## Techniques
- **MITRE ATT&CK** : T1003.001 (LSASS), T1555 (Credentials from Password Stores), T1552 (Unsecured
  Credentials), T1003.004 (LSA secrets).
- **LSASS** : dump mémoire → hashes/tickets (nécessite SeDebug/admin, sauf si PPL/CG).
- **DPAPI** : déchiffrer les blobs via la master key (mot de passe) ou la **domain backup key** (DC) →
  secrets navigateurs, Credential Manager, RDP, clés d'apps.

## Déroulé (principe)
1. Accès admin → dump LSASS (module 56) si PPL/CG absents.
2. DPAPI : récupérer master key + blobs → déchiffrer (SharpDPAPI/Mimikatz).
3. Domain backup key (DC compromis) → déchiffrer DPAPI de tout le domaine.

## Ancrage réel
Le vol de secrets DPAPI (cookies, mots de passe navigateurs) est devenu un objectif majeur
(« infostealers »). La domain backup key est un bijou de la couronne si un DC tombe.

## Résultat attendu
Comprendre ce que protègent PPL/Credential Guard et pourquoi la domain backup key est Tier 0 (`defend.md`).
