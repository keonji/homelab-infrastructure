terraform {
  required_version = "~> 1.5.0"
  backend "local" {
    path = "./terraform.tfstate"
  }
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
/*
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.10.4"
    }
*/
    ansiblevault = {
      source  = "MeilleursAgents/ansiblevault"
      version = "3.0.1"
    }
  }
}

provider "ansiblevault" {
  vault_path   = "../../../ansible/.vault.pass"
  root_folder  = "../../../ansible"
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.2:8006/api2/json"
  pm_user         = data.ansiblevault_path.proxmox_user.value
  pm_password     = data.ansiblevault_path.proxmox_password.value
  pm_tls_insecure = true
}

/*
  provider "routeros" {
  hosturl  = "api://192.168.0.1:8728"
  username = data.ansiblevault_path.mikrotik_user.value
  password = data.ansiblevault_path.mikrotik_password.value
  insecure = true
}
*/
