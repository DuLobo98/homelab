# Storage and data protection

## Storage classes

| Class | Backend | Replicas | Reclaim policy | Intended use |
| --- | --- | --- | --- | --- |
| `longhorn` (default) | Longhorn | 2 | Retain | General persistent workloads |
| `longhorn-critical` | Longhorn | 3 | Retain | Critical persistent data |
| `nfs` | NAS export `192.168.1.205:/volume1/homelab/k8s` | NAS-managed | Retain | Workloads requiring NFS semantics |

Each Talos node has a dedicated 200 GiB data disk. Talos provisions it as the `longhorn` user volume and mounts it at `/var/mnt/longhorn`. The Longhorn default data path is that mount. Longhorn and NFS CSI run in privileged namespaces because they require host-level storage access.

`Retain` prevents automatic backend deletion when a PersistentVolumeClaim is deleted. It does not replace an intentional data-retention process; operators must remove retained volumes explicitly when decommissioning a workload.

## Backup design

Longhorn sends backups to the RustFS S3-compatible target `s3://backups-longhorn@us-east-1/`. Credentials and endpoint configuration are obtained through External Secrets from 1Password.

| Volume group | Snapshots | Backups | Retention |
| --- | --- | --- | --- |
| General | Daily snapshot | Daily, weekly, monthly | 14 daily; 52 weekly; 12 monthly backups |
| Critical | Hourly snapshot | Daily, weekly, monthly forced full backups | 48 hourly snapshots; 14 daily; 52 weekly; 12 monthly backups |

General full backups run every 7th daily backup, every 4th weekly backup, and every 3rd monthly backup. Critical jobs force a full backup. Snapshot cleanup runs daily for general volumes and every two hours for critical volumes.
