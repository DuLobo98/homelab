# Homelab Documentation

This repository contains infrastructure and documentation for my homelab setup.

## Machine IPs

|          Machine Name           |   IP Address   |               Purpose               |
|---------------------------------|----------------|-------------------------------------|
| pve-01                          | 192.168.0.100  | Proxmox Virtual Environment         |
| k8s-test-control-plane-01       | 192.168.0.200  | Kubernetes Control Plane - Testing  |
| k8s-test-worker-01              | 192.168.0.201  | Kubernetes Worker - Testing         |
| k8s-test-worker-02              | 192.168.0.202  | Kubernetes Worker -Testing          |

## Folder Structure

```
homelab/
├── README.md
├── proxmox/                                       # Proxmox-related resources
│   └── scripts/                                   # Scripts for managing Proxmox
│       └── create-ubuntu-noble-cloudinit.sh       # Script to create Ubuntu 24.04 cloud-init templates
```