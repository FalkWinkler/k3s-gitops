terraform {
  required_version = ">= 0.13.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.1"
    }
  }
}

data "sops_file" "cloudinit_secrets" {
  source_file = "secret.sops.yaml"
}

provider "proxmox" {
  pm_api_url      = "https://${var.proxmox-host}:8006/api2/json"
  pm_user         = "terraform-prov@pve"
  pm_password     = var.password
  pm_tls_insecure = true
  pm_parallel     = 1
  #pm_debug        = true
  pm_api_token_id     = "terraform-prov@pve!mytoken"
  pm_api_token_secret = "0bab4ffc-d570-4d0d-83e9-75f5b480e5d2"
}


resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count       = var.num_k3s_masters
  name        = "k3s-master-${count.index}"
  target_node = var.server_node
  clone       = var.template_vm_name
  ssh_user    = var.ssh_user
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.num_k3s_masters_mem
  cores       = 2
  vmid        = 300 + count.index

  ipconfig0 = "ip=192.168.10.8${1 + count.index}/24,gw=192.168.10.1"

  searchdomain = var.search_domain
  nameserver   = var.nameserver
  sshkeys      = file("~/.ssh/id_ed25519.pub")
  ciuser       = data.sops_file.cloudinit_secrets.data["cloudinit_username"]
  cipassword   = data.sops_file.cloudinit_secrets.data["cloudinit_password"]
  bootdisk     = "scsi0"


  disk {
    type    = "scsi"
    size    = "25G"
    ssd     = 1
    storage = "local-zfs"
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  #sshkeys      = data.sops_file.secrets.data["k8s.ssh_key"]
}

resource "proxmox_vm_qemu" "proxmox_vm_workers" {
  count        = var.num_k3s_nodes
  name         = "k3s-worker-${count.index}"
  target_node  = var.server_node
  clone        = var.template_vm_name
  ssh_user     = var.ssh_user
  os_type      = "cloud-init"
  agent        = 1
  memory       = var.num_k3s_nodes_mem
  cores        = 4
  vmid         = 310 + count.index
  ipconfig0    = "ip=192.168.10.9${1 + count.index}/24,gw=192.168.10.1"
  searchdomain = var.search_domain
  nameserver   = var.nameserver
  sshkeys      = file("~/.ssh/id_ed25519.pub")
  ciuser       = data.sops_file.cloudinit_secrets.data["cloudinit_username"]
  cipassword   = data.sops_file.cloudinit_secrets.data["cloudinit_password"]
  bootdisk     = "scsi0"

  disk {
    type    = "scsi"
    size    = "25G"
    ssd     = 1
    storage = "local-zfs"
  }
  disk {
    type    = "scsi"
    size    = "120G"
    ssd     = 1
    storage = "SAMSUNG_SSD"
  }
  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

}

resource "local_file" "k3s_file" {
  content = templatefile("./templates/k8s.tpl", {
    k3s_masters = tomap({
      for instance in proxmox_vm_qemu.proxmox_vm_master :
      instance.name => instance.default_ipv4_address
    }),
    k3s_workers = tomap({
      for instance in proxmox_vm_qemu.proxmox_vm_workers :
      instance.name => instance.default_ipv4_address
    }),
    ansible_ssh_private_key_file = "~/.ssh/id_ed25519"
  })
  filename = "../../ansible/inventory/hosts.yml"
}

output "Master-IPS" {
  value = ["${proxmox_vm_qemu.proxmox_vm_master.*.default_ipv4_address}"]
}
output "Worker-IPS" {
  value = ["${proxmox_vm_qemu.proxmox_vm_workers.*.default_ipv4_address}"]
}
