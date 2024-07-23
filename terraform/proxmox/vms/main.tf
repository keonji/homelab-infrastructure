module "vm-synology" {
  source      = "../modules/synology"
  vmid        = 100
  name        = "vm-synology"
  target_node = "proxmox"
  cores       = 4
  memory      = 16 * 1024
  disk_size   = 3800
#  ip          = "192.168.0.3"
}

module "vm-wireguard" {
  source      = "../modules/vm"
  vmid        = 101
  name        = "vm-wireguard"
  target_node = "proxmox"
  cores       = 2
  memory      = 2 * 1024
  disk_size   = 60
#  ip          = "192.168.0.6"
}
