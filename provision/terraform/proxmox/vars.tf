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
  default = "192.168.178.150"

}

variable "nameserver" {
  type = string
  description = "die Ip Adresse des Nameserver"
  default ="192.168.178.1"
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
 default = 3
}

variable "num_k3s_nodes_mem" {
 default = "4096"
}

variable "num_dns_nodes_mem" {
 default = "2048"
}

variable "tamplate_vm_name" {
 default = "ubuntu-focal-cloudinit-template"
}

variable "server_node" {
  default = "server"
}

variable "sshkeys" {
  description = "ssh keys to drop onto each vm"
  type = string
  default = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMXKFyFnq8vT0dbNScEehy11KQ/h1g1cebPAM6pxpRZhBDRTbYjcAhKcJLXvTDAx4SnhQwAWUMob3HWoHRrJoX3y0yuoG473EwQCAPe/z1OJ8E2BYqsZfVmEx52Dmj2zScJPU+jh53dPmlhzCn0aKsOrEtKSq5Xr2F+7zIlOCi6v8xXDm3zu76NjCw9S4jRYvauvQwGvEBrNhDnxc1mqOO3rMVCYgNZqCdv/5IO0bIkClitsNZyanxOj3i02E52b7n4zy4v5+HHV9hV9cY1moUdIN693LgQr5HYCg1IUdzzqx8g3brzA/FMPLP97X7suzxa9MLfh4SZdBD7UZoJYy3cE9AwSrcZHHVYnXUdyKlghcPiua63C6ulsedr/igs3iXSTHJ7hS7K2G/qq4Vh/x2XgCf03VnDTls7W5bw4mOMD994SmzCrZJLies4YrTNnd47Iw78n8wWlp5Z5+Lx1eyJu2DjbWnBuFjiVIvlbbcep+5FlT0T/f1vPUNCtHCGs8= falk@ubuntu-falk
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1vRPjiOb/VzYEcO4jW5HQ/EwMLRQ6Ebxu7/LgT16q/ADki/ACn4xnXI0LnI7wsJTglDb+nAs+kWbQlKU5QU1K65lCgwYfSi9sYBk22UFv8GIBDFwjZno3cis7ED0xm3CREqeYMEVniXDHuixA64F6gODijg6DNlODbFJMzRTFdLw0Fofwn1ogeCAGelmENmIbAdb09bOkH9HmYydjH0FZWnNQuqxIBS5zyQ0KciplYqz94nyIulNQvG40V+AykeMShFIN+F/tmoJ5DUhrwCUcm4LS6xgPPN/loFKSF8caJkNLLeaQQxkDSHNNAK8AadUQpQNizCLEtRQCL+5oeJcH falkw@DESKTOP-FALK
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJXJowAcdUA2xdAhr+s5rGrdXSDtAZWv/P/5bxTyShxOzYoVxBWBysYqq6lGdjmMttUYZvdFSLpLmin+bogI187Rb4Pu4mdNscKU8b1A0CMq3649umafq51f+1qN0haEZHE657Vix7aIDmIxGXlHx95fiC3V8wcaDFuqmO5QX1Bz9kby9MbQ7Xsh6wwItF4++BjINHATwrH6BgWfl42eaXk8mHn1wwlOP61B8VcuiEa+nHXdDmYhGmBRAMUCiYh6hLdb5AKaGvNZcrgdExKDfmSVbhn4Somv2tR9sqfrPYqJI/Nk2A/S2wDYklBQAFcVjh+TNr3XWkAy6HCm0fJ6Mf2nIHwt1VWBm/4BCvy8RiBm6UM/07ehsYGsslq56GK4T3fnEJxs4B0I2MUp3DPtG1G2d58O9fjh2J0b4EqnqwP/l1CcFIMofFnJRW5tqWx+4YT2WB02WP2qYnYH0RtLiBnZ8vcmubXlHBcUKBerSUR5Ojk+IwgRkbRiudJHdhvm8= falk@DESKTOP-FALK
  EOF
}
variable "ssh_user" {
  description = "user to put ssh keys under"
  type = string
  default = "ubuntu"
}
