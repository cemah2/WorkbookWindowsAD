# Attack — Pourquoi la PKI est une cible stratégique

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Vue d'ensemble ; l'exploitation concrète (ESC1-ESC16)
> est au module 43.

## Principe
Un certificat d'authentification valide = **une identité**. Si un attaquant obtient un certificat
pour un compte à privilèges (ou détourne le mapping), il s'authentifie **en tant que** ce compte —
sans mot de passe, et souvent de façon **persistante** (valide tant que le cert n'est pas révoqué).

## Angles d'attaque (catégories, détail module 43)
- **MITRE ATT&CK** : T1649 (Steal or Forge Authentication Certificates).
- Templates mal configurés (ESC1-ESC3, ESC9/10…), permissions sur la CA (ESC7), relais NTLM vers
  l'enrôlement web (ESC8), CA/objets PKI modifiables (ESC4, ESC5), mapping faible, etc.

## Pourquoi la conception compte
- **Root hors-ligne** : limite l'impact d'une Issuing compromise.
- **Durées & révocation** : un certificat volé reste valide longtemps si durées longues/révocation absente.
- **NTAuthCertificates / mapping** : point de confiance ; un ajout malveillant = auth universelle.

## Résultat attendu
Comprendre que les décisions de conception (module présent) déterminent l'exposition aux ESC.
