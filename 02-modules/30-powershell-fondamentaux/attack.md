# Attack — PowerShell comme outil offensif (LOLBin)

> ⚠️ Lab isolé uniquement (voir LEGAL.md). On comprend pourquoi PowerShell est très utilisé en
> attaque, pour mieux le journaliser/détecter (détails offensifs en Phase 8).

## Techniques
- **MITRE ATT&CK** : T1059.001 (PowerShell), T1027 (Obfuscation), T1105 (Ingress Tool Transfer).
- **Principe** : PowerShell est présent partout, puissant et scriptable → "living off the land".

## Exemples d'abus (conceptuels)
- `-EncodedCommand <base64>` pour masquer la commande.
- Téléchargement/exécution **en mémoire** (`IEX (New-Object Net.WebClient).DownloadString(...)`).
- Désactivation/évasion d'AMSI (P8), bypass d'ExecutionPolicy (qui n'est PAS une barrière de sécurité).

## Démonstration minimale (défensive)
Observer ce que le logging capture d'une commande encodée (voir defend.md pour activer les logs) :
```powershell
# commande bénigne encodée, juste pour voir la trace 4104
$b = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("Get-Date"))
powershell -EncodedCommand $b
```

## Ancrage réel
La quasi-totalité des intrusions Windows utilise PowerShell à un moment. D'où l'importance du
Script Block Logging et d'AMSI — c'est l'angle défensif du workbook.

## Résultat attendu
Comprendre l'usage offensif pour justifier le durcissement/logging de `defend.md`.
