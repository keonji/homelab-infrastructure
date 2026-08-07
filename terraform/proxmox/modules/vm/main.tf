terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc08"
    }
  }
}

resource "proxmox_vm_qemu" "vm_qemu" {
  name               = var.name
  clone              = var.template
  target_node        = var.target_node
  vmid               = var.vmid
  memory             = var.memory
  full_clone         = true
  start_at_node_boot = true
  os_type            = "cloud-init"
  qemu_os            = "l26"
  agent              = 1
  scsihw             = "virtio-scsi-single"

  cpu {
    cores   = var.cores
    sockets = 1
    type    = var.cpu_type
  }

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
    id       = 0
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
