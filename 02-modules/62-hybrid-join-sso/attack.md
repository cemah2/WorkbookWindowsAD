# Attack — Pass-the-PRT & phishing de tokens (aperçu)

> ⚠️ Lab/tenant de test uniquement. Détail et outillage au module 63.

## Techniques
- **MITRE ATT&CK** : T1550.001 (Application Access Token), T1528 (Steal App Access Token),
  T1621 (MFA Request Generation), T1078.004.
- **Pass-the-PRT** : extraire le PRT (+ session key) d'un appareil compromis (Mimikatz/ROADtoken/
  requestaadrefreshtoken) → obtenir des tokens cloud → SSO en tant que la victime.
- **Device code phishing** : envoyer un flux device-code ; la victime valide → tokens (pas besoin du PRT).
- **Token theft via cookie** : récupérer le cookie PRT (x-ms-RefreshTokenCredential).

## Déroulé (principe)
1. Compromettre un poste HAADJ (admin local).
2. Extraire le PRT (si TPM absent/contournable) → `roadtx`/ROADtools pour obtenir des access tokens.
3. Accéder aux ressources cloud (Graph, M365) en tant que la victime.

## Ancrage réel
Le vol de tokens/PRT et le device code phishing sont des techniques cloud en forte croissance,
utilisées pour contourner le MFA (le token porte déjà la session authentifiée).

## Résultat attendu
Comprendre que l'appareil joint + PRT = cible cloud ; durcissement au module 63/64 (`defend.md`).
