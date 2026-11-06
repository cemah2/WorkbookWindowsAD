# Drills — PowerShell Remoting

## Drill 1 — Invoke-Command fan-out (10 min)
- **Étapes** : exécute `Get-Service Spooler` sur 2-3 machines en une commande.
- **Observer** : objets retournés avec `PSComputerName`.
- **Pourquoi** : la puissance du parallélisme.

## Drill 2 — Session persistante (10 min)
- **Étapes** : `New-PSSession`, enchaîne 2-3 `Invoke-Command -Session`, puis `Remove-PSSession`.
- **Pourquoi** : efficacité pour plusieurs actions.

## Drill 3 — JEA minimal (15 min)
- **Étapes** : expose uniquement `Restart-Service` à un groupe via JEA ; connecte-toi et vérifie
  que seules ces commandes marchent.
- **Pourquoi** : déléguer sans donner l'admin complet.

## Drill 4 — Le double-hop (10 min)
- **Étapes** : dans une session distante, tente d'accéder à une 2e ressource réseau → échec
  (double-hop) ; observe le comportement.
- **Pourquoi** : comprendre cette limite de sécurité.

## Drill break-fix — WinRM injoignable (10 min)
- **Casse** : coupe le service WinRM ou ferme la règle pare-feu sur une cible.
- **Diagnostique** : `Test-WSMan` échoue ; vérifie service + pare-feu.
- **Répare** : `Enable-PSRemoting` / règle pare-feu, `Test-WSMan` repasse.
