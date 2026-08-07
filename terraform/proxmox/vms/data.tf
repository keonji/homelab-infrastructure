data "ansiblevault_path" "proxmox_user" {
  path = "vault.yml"
  key  = "vault_proxmox_terraform_user"
}

data "ansiblevault_path" "proxmox_password" {
  path = "vault.yml"
  key  = "vault_proxmox_terraform_password"
}
