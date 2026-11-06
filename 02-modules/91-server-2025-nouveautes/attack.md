# Attack — BadSuccessor (escalade via dMSA, lab isolé)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Compréhension + détection ; on ne fournit pas d'outil clé en
> main, on explique le mécanisme pour le défendre.

## Technique
- **MITRE ATT&CK** : T1098 (Account Manipulation), T1078 (Valid Accounts), T1134 (impersonation).
- **Principe (BadSuccessor, 2025)** : avec un droit d'**écriture/création** sur une OU (ex. CreateChild
  pour la classe dMSA, ou GenericAll sur un dMSA), un attaquant crée/configure un **dMSA** et le désigne
  **successeur** d'un compte **privilégié** → le KDC lui accorde le contexte d'authentification de ce
  compte → escalade vers Domain Admin **sans** compromettre directement le compte cible.

## Pré-requis
- Au moins un DC **Windows Server 2025** (dMSA) ; droits d'écriture adéquats sur une OU/dMSA.

## Déroulé (principe)
1. Recon : trouver une OU où l'on peut créer des dMSA (ACL, `Find-DmsaRisk.ps1`).
2. Créer un dMSA et écrire les attributs de succession pointant vers un compte privilégié.
3. S'authentifier en tant que le dMSA → obtenir le contexte du compte ciblé.

## Ancrage réel
BadSuccessor (publié en 2025 par Akamai) a marqué les esprits : une escalade vers DA depuis des droits
modestes, via une **nouvelle** fonctionnalité. Illustration de l'importance de la veille.

## Résultat attendu
Comprendre le vecteur pour **restreindre** la création de dMSA et le **détecter** (`defend.md`).
