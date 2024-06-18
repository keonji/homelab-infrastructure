terraform {
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
  }
}

resource "proxmox_vm_qemu" "vm_qemu" {
  name        = var.name
  clone       = var.template
  target_node = var.target_node
  vmid        = var.vmid
  cores       = var.cores
  memory      = var.memory
  full_clone  = true
  onboot      = true
  cpu         = var.cpu_type
  sockets     = 1
  os_type     = "cloud-init"
  qemu_os     = "l26"
  agent       = 1
  scsihw      = "virtio-scsi-single"
  disks {
    ide {
      ide3 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size       = var.disk_size
          storage    = "local-lvm"
          emulatessd = true
          iothread   = true
          discard    = true
          backup     = false
        }
      }
    }
  }
  network {
    bridge   = "vmbr0"
    firewall = false
    macaddr  = local.macaddr
    model    = "virtio"
  }

  ipconfig0 = "ip=dhcp"

  lifecycle {
    ignore_changes = [
      ciuser,
      sshkeys,
      ipconfig0,
    ]
  }
}

/*
resource "routeros_ip_dhcp_server_lease" "dhcp_lease" {
  address     = var.ip
  mac_address = local.macaddr
}

resource "routeros_ip_dns_record" "dns_record" {
  name    = "${var.name}.pavelshapovalov.ru"
  address = var.ip
  type    = "A"
  comment = "VM"
  ttl     = "1d"
}
*/
