# Build — Hybrid join & observer le PRT (lab)

## Pré-requis
- Entra Connect opérationnel (module 61) avec **device writeback**/configuration HAADJ. Un poste
  Windows joint au domaine CORP.

## Étape 1 — Configurer la jonction hybride (HAADJ)
- Dans Entra Connect : activer **Hybrid Azure AD join** (assistant Device options).
- GPO / SCP (Service Connection Point) pour que les postes s'enregistrent dans Entra.

## Étape 2 — Vérifier l'état de jonction d'un poste
```cmd
dsregcmd /status
:: Regarder : AzureAdJoined : YES, DomainJoined : YES  (HAADJ)
:: et la section SSO State / AzureAdPrt : YES
```

## Étape 3 — Observer le PRT
```cmd
dsregcmd /status
:: AzureAdPrt : YES  -> un PRT est présent
:: NgcSet / TPM : indique la protection matérielle
```

## Étape 4 — Tester le SSO cloud
Depuis le poste HAADJ, ouvrir une app M365 (ex. portail Office) → connexion sans ressaisir le mot de
passe (SSO via PRT).

## Étape 5 — Vérifier côté Entra
```powershell
Get-MgDevice -Top 10 | Select DisplayName, TrustType, IsCompliant, OperatingSystem
# TrustType : ServerAd (HAADJ), AzureAd (AADJ), Workplace (registered)
```

## Vérification
- `dsregcmd /status` montre HAADJ + AzureAdPrt YES ; l'appareil apparaît dans Entra (TrustType ServerAd).

## Pièges courants
- SCP mal configuré → les postes ne deviennent pas HAADJ.
- Pas de TPM → PRT moins protégé (surface d'attaque accrue).
- Horloge/Connectivité (la jonction hybride a plusieurs prérequis réseau).
