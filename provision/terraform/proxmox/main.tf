terraform {
  required_version = ">= 0.13.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=2.9.3"
    }
     sops = {
      source = "carlpett/sops"
      version = "0.6.3"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://${var.proxmox-host}:8006/api2/json"
  pm_user         = "terraform-prov@pve"  
  pm_password     = var.password
  pm_tls_insecure = true
  pm_parallel     = 10  
  pm_debug        = true
}


resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count       = var.num_k3s_masters
  name        = "k3s-master-${count.index}"
  target_node = var.server_node
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.num_k3s_masters_mem
  cores       = 4

  ipconfig0 = "ip=192.168.178.8${count.index + 1}/24,gw=192.168.178.1"

}

resource "proxmox_vm_qemu" "proxmox_vm_workers" {
  count       = var.num_k3s_nodes
  name        = "k3s-worker-${count.index}"
  target_node = var.server_node
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  agent       = 1
  memory      = var.num_k3s_nodes_mem
  cores       = 4

  ipconfig0 = "ip=192.168.178.9${count.index + 1}/24,gw=192.168.178.1"

}

data "template_file" "k8s" {
  template = file("./templates/k8s.tpl")
  vars = {
    k3s_master_ip = "${join("\n", [for instance in proxmox_vm_qemu.proxmox_vm_master : join("", [instance.default_ipv4_address, " ansible_ssh_private_key_file=", var.pvt_key])])}"
    k3s_node_ip   = "${join("\n", [for instance in proxmox_vm_qemu.proxmox_vm_workers : join("", [instance.default_ipv4_address, " ansible_ssh_private_key_file=", var.pvt_key])])}"
  }
}

# resource "local_file" "k8s_file" {
#   content  = data.template_file.k8s.rendered
#   filename = "../inventory/my-cluster/hosts.ini"
# }


# provider "sops" {}


# data "sops_file" "secrets" {
#   source_file = "secrets.enc.json"
# }

