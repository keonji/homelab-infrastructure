module "vm-nextcloud" {
  source      = "../modules/vm"
  vmid        = 100
  name        = "vm-nextcloud"
  target_node = "proxmox"
  cores       = 4
  memory      = 16 * 1024
  disk_size   = 3800
#  ip          = "192.168.0.3"
}
