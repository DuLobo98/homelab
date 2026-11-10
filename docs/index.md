# Lobo Tech Works Homelab

This is the operational manual for the homelab declared in this repository. The code is documentation: Terraform, Kubernetes manifests, Tasks, and scripts are authoritative for executable configuration; these pages document their intent, dependencies, and safe operation.

## Scope

| Layer | Implementation |
| --- | --- |
| Virtualisation | Proxmox VE |
| Kubernetes operating system | Talos Linux |
| Delivery | Argo CD app-of-apps from GitHub `main` |
| Networking | Cilium L2, Traefik, Gateway API, Technitium DNS |
| Secrets | 1Password and External Secrets Operator |
| TLS | cert-manager and Let's Encrypt |
| Storage | Longhorn and NFS CSI |
| Monitoring | Prometheus, Alertmanager, Grafana, node exporter |

## Use this manual

- Start at [Architecture](architecture.md) for system boundaries and dependencies.
- Use [Bootstrap](bootstrap.md), [Health checks](operations/health-checks.md), and [Backups and recovery](operations/backups-and-recovery.md) for operations.
- Use the [reference](reference/gitops.md) pages to locate implementation ownership and exact configuration.

## Authoritative sources

| Concern | Source |
| --- | --- |
| VM topology, Talos version, node configuration | [`infrastructure/proxmox/`](https://github.com/DuLobo98/homelab/tree/main/infrastructure/proxmox) |
| Cluster applications and Helm versions | [`kubernetes/`](https://github.com/DuLobo98/homelab/tree/main/kubernetes) |
| Supported operator commands | [`Taskfile.yaml`](https://github.com/DuLobo98/homelab/blob/main/Taskfile.yaml) |
| Tool versions | [`mise.toml`](https://github.com/DuLobo98/homelab/blob/main/mise.toml) |

