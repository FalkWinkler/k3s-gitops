variable "username" {
  description = "The username for the DB master user"
  type        = string
  sensitive = false
  default = "terraform-pro@pvev"
}
variable "password" {
  description = "The password for the DB master user"
  type        = string
  sensitive = true
  default = ""
}

variable "proxmox-host" {
  description = "The proxmox host name"
  type        = string
  default = "192.168.10.254"

}

variable "nameserver" {
  type = string
  description = "die Ip Adresse des Nameserver"
  default ="192.168.10.1"
}


variable "search_domain" {
  type = string
  description = "die Such Domain"
  default ="home.lan"
}

variable "pvt_key" {
  default = "~/.ssh/id_rsa"
}

variable "num_k3s_masters" {
 default = 1
}

variable "num_k3s_masters_mem" {
 default = "4096"
}

variable "num_k3s_nodes" {
 default = 2
}

variable "num_k3s_nodes_mem" {
 default = "12288"
}

variable "tamplate_vm_name" {
 default = "ubuntu-2204-cloudinit-template"
}

variable "server_node" {
  default = "pve"
}

variable "sshkeys" {
  description = "ssh keys to drop onto each vm"
  type = string
  default = <<EOF
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAayW2DEKQSF8A5SfdbuepRrSWKPP/g9rX3yLwxEHuNL falk@falk-pc
  EOF
}
variable "ssh_user" {
  description = "user to put ssh keys under"
  type = string
  default = "falk"
}
