# Inventory

This page records stable private-network identifiers declared in Git. 

## Kubernetes control plane

| Name | Proxmox host | Address | VM ID | Allocation | Disks |
| --- | --- | --- | --- | --- | --- |
| `k8s-prod-control-plane-01` | `pve-01` | `192.168.1.211/24` | 1001 | 4 vCPU, 12 GiB RAM | 50 GiB OS; 200 GiB Longhorn data |
| `k8s-prod-control-plane-02` | `pve-02` | `192.168.1.212/24` | 1002 | 4 vCPU, 12 GiB RAM | 50 GiB OS; 200 GiB Longhorn data |
| `k8s-prod-control-plane-03` | `pve-03` | `192.168.1.213/24` | 1003 | 4 vCPU, 12 GiB RAM | 50 GiB OS; 200 GiB Longhorn data |

The Kubernetes API virtual IP is `192.168.1.210`.

## Proxmox hosts

The following inventory is derived from the running hosts. Runtime state changes independently of Git.

| Host | Private address | CPU | Memory | Boot disk | Data disk |
| --- | --- | --- | --- | --- | --- |
| `pve-01` | `192.168.1.201` | Intel Core i5-6500T, 4 cores | 16 GB | 240 GB SATA SSD | 1 TB NVMe SSD |
| `pve-02` | `192.168.1.202` | Intel Core i5-7500, 4 cores | 16 GB | 120 GB SATA SSD | 1 TB NVMe SSD |
| `pve-03` | `192.168.1.203` | Intel Core i5-6500, 4 cores | 16 GB | 120 GB SATA SSD | 1 TB NVMe SSD |

## Load-balancer addresses

| Address | Consumer |
| --- | --- |
| `192.168.1.200` | Traefik ingress |
| `192.168.1.220`–`192.168.1.225` | General service pool |
| `192.168.1.230` | Technitium DNS |

## Other infrastructure addresses

| Address | Consumer |
| --- | --- |
| `192.168.1.205` | NAS NFS export and static DNS endpoint |

