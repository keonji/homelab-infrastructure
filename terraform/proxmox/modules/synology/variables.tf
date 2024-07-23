variable "vmid" {
  description = "Unique vm id"
  type        = number
}

variable "macaddr" {
  description = "vm mac address"
  type        = string
  default     = null
}

locals {
  macaddr = var.macaddr == null ? format("5A:EB:FA:%02d:%02d:%02d", floor(var.vmid / 100), var.vmid % 100, 0) : var.macaddr
}

variable "name" {
  description = "vm name"
  type        = string
}

variable "target_node" {
  description = "node to create the VM on"
  type        = string
}

variable "cores" {
  description = "vm vCPU"
  type        = number
}

variable "memory" {
  description = "vm memory(in MB)"
  type        = number
}

variable "disk_size" {
  description = "VM disk size(G)"
  type        = number
}

/*
variable "ip" {
  description = "vm ip"
  type        = string
}
*/
