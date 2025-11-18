# Homelab Documentation

This repository contains infrastructure and documentation for my homelab setup.

## Machine IPs

|          Machine Name           |   IP Address   |               Purpose               |
|---------------------------------|----------------|-------------------------------------|
| pve-01                          | 192.168.1.100  | Proxmox Virtual Environment         |
| pbs-01                          | 192.168.1.101  | Proxmox Backup Server               |
| k8s-prod-control-plane-01       | 192.168.1.200  | Kubernetes Control Plane - Prod     |
| k8s-prod-worker-01              | 192.168.1.201  | Kubernetes Worker - Prod            |
| k8s-prod-worker-02              | 192.168.1.202  | Kubernetes Worker - Prod            |

## Folder Structure

```
homelab/
├── infrastructure/                                # Infrastructure as Code
├── kubernetes/                                    # Kubernetes manifests and configs
├── scripts/                                       # Utility scripts
├── Taskfile.yaml                                  # Task automation
```
