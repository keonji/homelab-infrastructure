# Homelab-Infrastructure

This repo describes my home lab using IaC principles.

## Current inventory

| Host | Address | Managed by | Notes |
|---|---|---|---|
| `proxmox` | 192.168.0.2 | Ansible + Terraform | Proxmox VE 9 (Debian 13 trixie) |
| `vm-synology` | 192.168.0.3 | Terraform only | DSM 7.2.1, VM 100. Configured through the DSM web UI |
| UDM Pro | 192.168.0.1 | — | Router, outside of IaC |

There are two directories:

- `ansible` — configuration roles for the Proxmox host.
- `terraform` — VM definitions for the Proxmox node.

## Ansible

Requires Python 3.11+. Everything runs out of a local virtualenv — the Makefile
calls `.ansible_venv/bin/*` directly, so nothing is installed system-wide:

```sh
cd ansible
make install
```

| Target | What it does |
|---|---|
| `make install` | Creates the venv and installs `requirements.txt` + `requirements.yml` |
| `make lint` | `--syntax-check` |
| `make check` | Dry run (`--check --diff`) |
| `make run` | Applies the playbook (`-D`) |
| `make clean` | Removes the venv |

Run a single role by tag:

```sh
.ansible_venv/bin/ansible-playbook -D -t role_name homelab.yml
```

### Roles

| Role | Purpose |
|---|---|
| `ssh_root_key` | Manages authorized keys from `group_vars/all/root_ssh_keys.yml` |
| `linux_common` | Base packages |
| `linux_node_exporter` | Prometheus node_exporter as a systemd unit |
| `proxmox_nginx` | TLS reverse proxy for the Proxmox web UI (80/443 → localhost:8006) |
| `proxmox_user_role` | Keeps the `Terraform` PVE role, its privileges and the ACL in sync |

### Notes

- Secrets live in `ansible/vault.yml` (ansible-vault). The password file is `ansible/.vault.pass`, referenced from `ansible.cfg` — it is gitignored.
- `proxmox_user_role` re-syncs privileges on every run. PVE 9 dropped `VM.Monitor` in favour of `VM.GuestAgent.*`, so the privilege list is version-specific.
- Output formatting uses `stdout_callback = default` + `result_format = yaml`. The old `community.general.yaml` callback was removed in that collection's 12.0.0; the built-in option replaces it since ansible-core 2.13.
- `interpreter_python` is pinned to `/usr/bin/python3` so a Debian upgrade cannot silently switch the remote interpreter.

## Terraform

```sh
cd terraform/proxmox/vms
make init
make plan
make apply
```

## SSH with a password-protected key

Start the agent and add the key:

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```
