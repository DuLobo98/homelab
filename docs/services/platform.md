# Platform services

These services establish platform capabilities. Implementation details and versions are defined in `kubernetes/`.

| Service | Interface | Purpose |
| --- | --- | --- |
| Argo CD | <https://argocd.home.lobotechworks.pt> | GitOps reconciliation and deployment status |
| Cilium | <https://hubble.home.lobotechworks.pt> | CNI, load balancing, and network observability |
| Gateway API | — | Gateway API resource definitions |
| Traefik | <https://traefik.home.lobotechworks.pt/dashboard/> | HTTPS gateway and HTTP routing |
| cert-manager | — | Certificate issuance and renewal |
| External Secrets Operator | — | Kubernetes secrets from 1Password |
| external-dns | — | Internal DNS record reconciliation |
| Technitium | <https://dns.home.lobotechworks.pt> | Internal DNS service |
| Longhorn | <https://longhorn.home.lobotechworks.pt> | Persistent volumes and backups |
| NFS CSI | — | NAS-backed dynamic provisioning |
| metrics-server | — | Kubernetes resource metrics |
| Prometheus stack | <https://grafana.home.lobotechworks.pt><br><https://prometheus.home.lobotechworks.pt><br><https://alertmanager.home.lobotechworks.pt> | Metrics, alerting, and dashboards |
