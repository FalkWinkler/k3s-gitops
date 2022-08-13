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
  default ="192.168.10.7"
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
 default = "4096"
}

variable "tamplate_vm_name" {
 default = "fedora-36-cloud-init"
}

variable "server_node" {
  default = "pve"
}

variable "sshkeys" {
  description = "ssh keys to drop onto each vm"
  type = string
  default = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDB4Yw7MJ2NvT6c7DM7C56jpxA8/868ODxbUHIDQc+TlEnDr1pQBBYIr5lEIR2safszLE1Fji1aRptTofd67CmEG9JeR0p1D4/7UTVGd49B88QdUURYb1uZ/FsM0z/AZsnV39LULfBSJfSuAfiN2Dh5Fgzmg1sSgJLizEpTiHttoRKs6lx8nlx60qOD93urr6OyF16xK2NWWuOgaevnRSJqPAxCh1YqjpiB8kRouqGwpkXKlPfT/e/AHZmcjHmBFrxQxnSvA0riqacMpvIpx8jS8Y57uF+ebGUY+ZRUuh40Vz9o78+Q4bSJ+rGqskR7ZVRNGwFyW5xsYgXh/lXMSr9ixjs2eJMLHNPKD4sqPReAkurvyH8dVXGP5lEFIPPzMQrwTB3WRYbvNJRARdxD8w6HRZ7zFFWuufrcciL0AEynEX+Kc/N6l40tAoEasj7z/bzaAkAMcLk01nSuB0wJR208pwTfbqjdmw5pDrLcJqcqVa0yhS7v2MhEvhGUtiOvI+6hdD+Mj5iRus/Wd8bZVLn5V5IgkCpUvUek3GJavtbGpy9FvIuN0pv+l+NbEEdyY1EMo+lYfzoy0BgyBKmWdKf2JsACV4zV7JK2+FuCGqcYpMqy8oWSYb7LbcjvaqX60rfA6tDsgadfrFx1obS/tS4Zr9cwIQzy1o2Hy3hy4bwjrw== falk@ubuntu-falk
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1vRPjiOb/VzYEcO4jW5HQ/EwMLRQ6Ebxu7/LgT16q/ADki/ACn4xnXI0LnI7wsJTglDb+nAs+kWbQlKU5QU1K65lCgwYfSi9sYBk22UFv8GIBDFwjZno3cis7ED0xm3CREqeYMEVniXDHuixA64F6gODijg6DNlODbFJMzRTFdLw0Fofwn1ogeCAGelmENmIbAdb09bOkH9HmYydjH0FZWnNQuqxIBS5zyQ0KciplYqz94nyIulNQvG40V+AykeMShFIN+F/tmoJ5DUhrwCUcm4LS6xgPPN/loFKSF8caJkNLLeaQQxkDSHNNAK8AadUQpQNizCLEtRQCL+5oeJcH falkw@DESKTOP-FALK
  EOF
}
variable "ssh_user" {
  description = "user to put ssh keys under"
  type = string
  default = "fedora"
}
