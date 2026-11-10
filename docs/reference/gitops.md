# GitOps delivery

## Delivery model

Argo CD uses the app-of-apps pattern. The bootstrap task creates the root `Application`; it watches `kubernetes/argocd/apps/` on the `main` branch. Every child application has automated sync, prune, self-heal, server-side apply, and bounded retry configured in its manifest.

The root is therefore the control point for desired state. Direct cluster changes are temporary and will normally be reverted by Argo CD.

## Reconciliation order

| Wave | Applications | Reason |
| --- | --- | --- |
| -1 | Cilium | Cluster networking is installed before routed workloads. |
| 0 | Argo CD, External Secrets, Gateway API, metrics-server, NFS CSI | Core controllers and CRDs. |
| 1 | cert-manager, Traefik | TLS and ingress depend on the preceding controllers. |
| 2 | Longhorn | Persistent volume capability. |
| 3 | n8n, Prometheus stack, Radar, Technitium | Stateful and observability workloads. |
| 4 | ExternalDNS, Media | DNS reconciliation and the separately sourced media application. |

Sync waves express ordering, not a guarantee that every dependency is healthy. Use Argo CD health status before treating an application change as complete.

## Sources

| Object | Location |
| --- | --- |
| Root application | [`kubernetes/argocd/root.yaml`](https://github.com/DuLobo98/homelab/blob/main/kubernetes/argocd/root.yaml) |
| Child application declarations | [`kubernetes/argocd/apps/`](https://github.com/DuLobo98/homelab/tree/main/kubernetes/argocd/apps) |
| Argo CD installation and configuration | [`kubernetes/argocd/`](https://github.com/DuLobo98/homelab/tree/main/kubernetes/argocd) |

## Configuration rules

1. Add a workload in its own `kubernetes/<name>/` directory with a `kustomization.yaml`.
2. Add a child `Application` with the correct namespace, source path, sync wave, and finalizer.
3. Store credentials as `ExternalSecret` objects; never commit `Secret.data` or tokens.
4. Route HTTP services through the Traefik Gateway using `HTTPRoute`; do not create unmanaged ingress paths.
5. Commit generated dashboards only through the supported `task monitoring:dashboards:*` tasks.
