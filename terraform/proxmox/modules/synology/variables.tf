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

variable "boot_disk_size" {
  description = "ARC loader boot disk size(M)"
  type        = string
  default     = "1852M"
}

variable "disk_size" {
  description = "VM data disk size(G)"
  type        = number
}
