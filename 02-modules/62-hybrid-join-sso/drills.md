# Drills — Hybrid join / PRT

## Drill 1 — dsregcmd /status (10 min)
- **Étapes** : lis la sortie, identifie AADJ/DomainJoined/AzureAdPrt/TPM.
- **Pourquoi** : la commande de diagnostic n°1 côté appareil.

## Drill 2 — SSO en action (10 min)
- **Étapes** : ouvre une app M365 depuis un poste HAADJ.
- **Observer** : pas de ressaisie (SSO via PRT).
- **Pourquoi** : comprendre l'expérience… et l'enjeu si le PRT est volé.

## Drill 3 — TrustType côté Entra (10 min)
- **Étapes** : `Get-MgDevice`, compare ServerAd/AzureAd/Workplace.
- **Pourquoi** : distinguer les états de jonction.

## Drill 4 — PRT & TPM (10 min)
- **Étapes** : vérifie si le PRT est lié au TPM (`dsregcmd /status`).
- **Pourquoi** : le TPM complique Pass-the-PRT (module 63).

## Drill break-fix — Pas de PRT (10 min)
- **Casse** : poste non enregistré / SCP absent.
- **Diagnostique** : `dsregcmd /status` → AzureAdPrt : NO.
- **Répare** : corrige l'enregistrement (SCP/GPO), re-teste.
