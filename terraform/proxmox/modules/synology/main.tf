terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc08"
    }
  }
}

resource "proxmox_vm_qemu" "vm_synology" {
  name               = var.name
  target_node        = var.target_node
  vmid               = var.vmid
  memory             = var.memory
  boot               = "order=sata0"
  os_type            = "ubuntu"
  qemu_os            = "l26"
  agent              = 1
  start_at_node_boot = true
  scsihw             = "virtio-scsi-single"

  cpu {
    cores   = var.cores
    sockets = 1
    type    = "host"
  }

  disks {
    sata {
      # ARC loader, залит в local:iso/arc.img и импортирован на диск
      sata0 {
        disk {
          size    = var.boot_disk_size
          storage = "local-lvm"
        }
      }
      sata1 {
        disk {
          size       = var.disk_size
          storage    = "local-lvm"
          emulatessd = true
          discard    = true
          backup     = false
          replicate  = false
        }
      }
    }
  }
  network {
    id       = 0
    bridge   = "vmbr0"
    firewall = false
    macaddr  = local.macaddr
    model    = "e1000"
  }

  ipconfig0 = "ip=dhcp"

  # VM создана вручную из ARC-loader, а не клонированием шаблона.
  # full_clone форсирует replacement, а на sata1 лежат данные NAS —
  # пересоздание недопустимо, поэтому фиксируем текущее состояние.
  full_clone = false

  lifecycle {
    prevent_destroy = true

    ignore_changes = [
      ciuser,
      sshkeys,
      ipconfig0,
      full_clone,
      vm_state,
      smbios,
      startup_shutdown,
      define_connection_info,
      desc,
      description,
      network,
      disks,
    ]
  }
}
