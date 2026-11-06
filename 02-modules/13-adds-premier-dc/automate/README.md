# Automate — Premier DC

On reproduit la promotion manuelle (`build.md`) en PowerShell, puis on prépare l'intégration IaC
(Phase 3). `New-FirstDC.ps1` installe le rôle AD DS et crée la forêt/domaine.

## Usage (sur un serveur préparé, lab uniquement)
```powershell
# Le mot de passe DSRM est demandé de façon sécurisée (jamais en clair dans le script/dépôt)
.\New-FirstDC.ps1 -DomainName "corp.meridian.com" -NetbiosName "CORP" `
                  -ForestMode "WinThreshold" -DomainMode "WinThreshold"
# WinThreshold = niveau fonctionnel 2016
```
Le serveur redémarre à la fin. Après redémarrage, pense à pointer le DNS client sur 127.0.0.1
et à ajouter un forwarder (voir build.md Étape 3) — géré aussi par le script si -SelfDns est fourni.

## Vers l'IaC (Phase 3)
Ce script sera appelé par Ansible/DSC après le provisionnement Terraform de la VM, pour un DC
"from zero" entièrement automatisé.
