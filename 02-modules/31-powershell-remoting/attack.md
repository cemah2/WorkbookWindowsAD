# Attack — WinRM pour le mouvement latéral

> ⚠️ Lab isolé uniquement (voir LEGAL.md). Exploitation détaillée en Phase 5.

## Techniques
- **MITRE ATT&CK** : T1021.006 (Windows Remote Management), T1059.001, T1550 (PtH/PtT via WinRM).
- **Outils** : `Invoke-Command`, `Enter-PSSession`, `evil-winrm`, NetExec (`winrm`).

## Déroulé (principe)
1. Avec un credential valide (ou un hash via PtH), se connecter en WinRM à une cible :
   ```bash
   netexec winrm 10.10.0.22 -u adm -p '***'
   evil-winrm -i 10.10.0.22 -u adm -p '***'
   ```
2. Exécution de commandes à distance → mouvement latéral, découverte, exécution d'outils.
3. **CredSSP** mal utilisé → vol de credentials sur la cible (double-hop exposé).

## Ancrage réel
WinRM/PSRemoting est un vecteur de mouvement latéral standard (très utilisé car natif et discret).
evil-winrm est un outil courant des opérateurs.

## Résultat attendu
Comprendre que WinRM doit être **segmenté, journalisé et respecter le tiering** — voir `defend.md`.
