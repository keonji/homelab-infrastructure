terraform {
  required_version = ">= 1.5"
  backend "local" {
    path = "./terraform.tfstate"
  }
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc08"
    }
    ansiblevault = {
      source  = "MeilleursAgents/ansiblevault"
      version = "3.0.1"
    }
  }
}

provider "ansiblevault" {
  vault_path  = "../../../ansible/.vault.pass"
  root_folder = "../../../ansible"
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.2:8006/api2/json"
  pm_user         = data.ansiblevault_path.proxmox_user.value
  pm_password     = data.ansiblevault_path.proxmox_password.value
  pm_tls_insecure = true
}
