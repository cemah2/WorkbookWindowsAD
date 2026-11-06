terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.60"   # épingler ; vérifier la dernière version compatible
    }
  }
}
provider "proxmox" {
  endpoint  = var.pve_endpoint
  api_token = var.pve_api_token
  insecure  = true   # lab uniquement (certificat auto-signé)
}
