terraform {
  required_version = "~> 1.5.0"
  backend "local" {
    path = "./terraform.tfstate"
  }
  required_providers {
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
  vault_path  = "../../../ansible/.vault.pass"
  root_folder = "../../../ansible"
}

/*
provider "routeros" {
  hosturl  = "api://192.168.0.1:8728"
  username = data.ansiblevault_path.mikrotik_user.value
  password = data.ansiblevault_path.mikrotik_password.value
  insecure = true
}
*/
