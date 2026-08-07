module "vm-synology" {
  source      = "../modules/synology"
  vmid        = 100
  name        = "vm-synology"
  target_node = "proxmox"
  cores       = 8
  memory      = 32 * 1024
  disk_size   = 3800
}
