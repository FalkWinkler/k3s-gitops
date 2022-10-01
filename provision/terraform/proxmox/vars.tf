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
 default = "12288"
}

variable "tamplate_vm_name" {
 default = "debian-bullseye-cloud-init"
}

variable "server_node" {
  default = "pve"
}

variable "sshkeys" {
  description = "ssh keys to drop onto each vm"
  type = string
  default = <<EOF
  ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAAds51MwgHpEOVQrC3CI1qDMnbi5uPLcwcxqYleQYy8ZIEwsskCJqoW0xhi6PSGE8J+xAKdkFGQiYYCLwH+Hf0hWAHh4K8sgug12yI9nfrMxHi+mCQMqhNbiBgWdbHolEo3lRI4qzGZ11krGPDgcujyMobeqQhVnWJsibzpY8G5Xx6bFQ== falkw@DESKTOP-FALK
  ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAEHHD2MtocVzM7dAYg351jKgXRnBON0JGX0eTB2jegEhgx+qpm/gyWekwRgGIHQI/v7i46nZ+lK3Zy3eVPZFnPmvQFULji5HQVX+IY2FeiFzYxT/q/OCGU9NoMccUEFFPk2PzHoA7SgNSuCqAsIjf0kdtMyWXeyj51f+7TDXR9qRLzBAQ== falk@ubuntu-falk
  EOF
}
variable "ssh_user" {
  description = "user to put ssh keys under"
  type = string
  default = "admin"
}
