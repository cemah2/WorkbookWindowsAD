# Build — Provisionner des VM Proxmox avec Terraform (dans CORP)

> On automatise la création des VM qu'on montait à la main (phase 0/1). Prérequis : un **template**
> Windows/Linux sur Proxmox (Packer, module Phase 0) et un **token API** Proxmox.

## Pré-requis
- Terraform installé ; token API Proxmox (Datacenter → Permissions → API Tokens).
- Un template cloud-init prêt (ex. `win2022-template`).

## Étape 1 — Provider & variables
`providers.tf` :
```hcl
terraform {
  required_providers {
    proxmox = { source = "bpg/proxmox", version = "~> 0.60" }
  }
}
provider "proxmox" {
  endpoint  = var.pve_endpoint
  api_token = var.pve_api_token   # depuis terraform.tfvars (NON commité)
  insecure  = true                # lab (certif auto-signé)
}
```
`variables.tf` : déclare `pve_endpoint`, `pve_api_token` (sensible), `node_name`, etc.

## Étape 2 — Une VM Windows à partir d'un template
`dc.tf` :
```hcl
resource "proxmox_virtual_environment_vm" "dc01" {
  name      = "PAR-DC-01"
  node_name = var.node_name
  clone { vm_id = var.win_template_id }     # clone du template
  cpu    { cores = 2 }
  memory { dedicated = 4096 }
  disk { datastore_id = "local-zfs"; interface = "scsi0"; size = 60 }
  network_device { bridge = "vmbr1"; vlan_id = 10 }      # VLAN EMEA
  agent  { enabled = true }
  # initialization (cloud-init) : hostname/IP si template Linux ; pour Windows, via sysprep/unattend
}
output "dc01_ip" { value = proxmox_virtual_environment_vm.dc01.ipv4_addresses }
```

## Étape 3 — Cycle de vie
```bash
terraform init          # télécharge le provider
terraform plan          # prévoit (diff)
terraform apply         # crée la VM
terraform destroy       # supprime (quand tu veux repartir de zéro)
```

## Étape 4 — Boucler sur plusieurs VM (for_each)
```hcl
variable "members" { default = { "PAR-FS-01" = 11, "NYC-FS-01" = 12 } }
resource "proxmox_virtual_environment_vm" "member" {
  for_each  = var.members
  name      = each.key
  node_name = var.node_name
  clone { vm_id = var.win_template_id }
  network_device { bridge = "vmbr1"; vlan_id = 10 }
}
```

## Étape 5 — Enchaîner avec la config (hand-off Ansible)
Après `apply`, exporter les IP (outputs) vers l'inventaire Ansible (module 33) → configuration.

## Vérification
```bash
terraform state list            # ressources gérées
terraform output dc01_ip        # IP de la VM créée
```
Les VM apparaissent dans Proxmox ; `destroy` les retire proprement.

## Pièges courants
- **Committer** `terraform.tfvars` ou `terraform.tfstate` (secrets !) → .gitignore les bloque.
- Version de provider non épinglée → surprises.
- Oublier le template/agent QEMU (pas d'IP remontée).
