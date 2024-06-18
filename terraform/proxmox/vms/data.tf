data "ansiblevault_path" "proxmox_user" {
  path = "vault.yml"
  key  = "vault_proxmox_terraform_user"
}

data "ansiblevault_path" "proxmox_password" {
  path = "vault.yml"
  key  = "vault_proxmox_terraform_password"
}

/*
data "ansiblevault_path" "mikrotik_user" {
  path = "vault.yml"
  key  = "vault_mikrotik_user"
}

data "ansiblevault_path" "mikrotik_password" {
  path = "vault.yml"
  key  = "vault_mikrotik_password"
}
*/
