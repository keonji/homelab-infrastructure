# Homelab-Infrastructure

This repo is describing my home lab using IaaC principles.

There are two directories:
- `ansible`
- `terraform`

Ansible directory contains a configuration roles that managing my Mikrotik router, Proxmox cluster, monitoring RPi, and MacOS nodes.
Terraform directory contains a runbooks that deploying VMs to the proxmox and setting up static IPs and DNS records on Mikrotik. 

## Run ansible playbook
```sh
 ansible-playbook -D -i inventories/servers -l label_name -t role_name homelab.yml
```
## Run ansible playbook with login/pass
### use
```sh
 --ask-pass
```
## Run ansible playbook with pass protected ssh
### Start the ssh-agent in the background.
```sh
 eval "$(ssh-agent -s)"
```
### Add SSH private key to the ssh-agent
```sh
 ssh-add ~/.ssh/id_rsa
 ssh-add ~/.ssh/id_ed25519
```