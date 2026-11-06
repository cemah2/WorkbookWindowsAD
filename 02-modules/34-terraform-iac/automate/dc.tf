# Exemple : provisionner le premier DC (VM) à partir d'un template. Config OS = Ansible/DSC ensuite.
resource "proxmox_virtual_environment_vm" "dc01" {
  name      = "PAR-DC-01"
  node_name = var.node_name

  clone { vm_id = var.win_template_id }

  cpu    { cores = 2 }
  memory { dedicated = 4096 }

  disk {
    datastore_id = "local-zfs"
    interface    = "scsi0"
    size         = 60
  }

  network_device {
    bridge  = "vmbr1"
    vlan_id = 10   # EMEA
  }

  agent { enabled = true }
}

output "dc01_ip" {
  value = proxmox_virtual_environment_vm.dc01.ipv4_addresses
}
