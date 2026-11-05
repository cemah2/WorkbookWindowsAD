# Automate — <SUJET>

> On refait le `build.md`, mais automatisé. Progression : **PowerShell d'abord**, puis **IaC**
> (DSC / Ansible / Terraform selon le cas).

## 1. PowerShell
`setup.ps1` — script idempotent reproduisant le build manuel.

## 2. IaC
<DSC (`*.ps1` configuration) / Ansible (`playbook.yml`) / Terraform (`*.tf`) selon le besoin.>

## Vérification / tests
<Pester, `Test-DscConfiguration`, ou commande de contrôle.>
