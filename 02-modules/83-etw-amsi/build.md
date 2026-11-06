# Build — Observer ETW & AMSI, détecter leur contournement (lab)

> On observe la télémétrie légitime, puis on apprend à repérer son absence/altération (signe d'évasion).

## Pré-requis
- VM Windows de lab + Sysmon (module 71) + PowerShell logging (module 30) + idéalement un EDR/Defender.

## Étape 1 — Observer ETW (PowerShell)
```powershell
# Lister des sessions ETW actives
logman query -ets
# Les events PowerShell (4104) transitent par ETW -> vérifier qu'ils arrivent
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" -MaxEvents 5 | Select Id, TimeCreated
```

## Étape 2 — Observer AMSI
```powershell
# Test d'intégration AMSI (chaîne de test standard EICAR-like AMSI) :
# 'AMSI Test Sample: 7e72c3ce-861b-4339-8740-0ac1484c1386'  -> doit être bloqué si AMSI/Defender actifs
```
(Si la chaîne de test est bloquée, AMSI fonctionne.)

## Étape 3 — Simuler un angle mort (compréhension)
- Comprendre qu'un **AMSI bypass** ferait exécuter la chaîne de test sans blocage, et qu'un **ETW patch**
  ferait disparaître les 4104 d'un process. (On ne fournit pas l'exploit ; on apprend à détecter l'effet.)

## Étape 4 — Détecter l'évasion
- **Corrélation** : process PowerShell actif **mais** aucun 4104 → suspicion d'ETW/logging tampering.
- **AMSI** : échecs d'init, chaînes de bypass connues dans les logs.
- **Sessions ETW** stoppées (logman) de façon inattendue.

## Étape 5 — Renforcer la collecte
- Activer **Script Block Logging** (module 30), **PowerShell transcription**, et s'appuyer sur un EDR
  avec capteurs **kernel/ETW-TI** (moins contournables que l'ETW user-mode).

## Vérification
```powershell
logman query -ets | Select-String "EventLog-Application","Sysmon"   # sessions attendues présentes
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" -MaxEvents 1
```

## Pièges courants
- Se fier à une seule source (ETW user-mode) facilement contournable → combiner les capteurs.
- Oublier que l'absence d'événement est elle-même un signal.
