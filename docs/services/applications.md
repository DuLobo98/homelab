# Applications

Application definitions are declared under `kubernetes/` and registered through the Argo CD app-of-apps configuration.

| Application | Interface | Purpose |
| --- | --- | --- |
| n8n | <https://n8n.home.lobotechworks.pt> | Workflow automation |
| Radar | <https://radar.home.lobotechworks.pt> | Kubernetes operations interface |
| Media | — | Private workload delivery |

## Adding an application

1. Create a dedicated directory in `kubernetes/<application>/` with its namespace, manifests, and `kustomization.yaml`.
2. Add an Argo CD `Application` under `kubernetes/argocd/apps/`.
3. Select a sync wave that respects its prerequisites.
4. Use an `ExternalSecret` for sensitive configuration and confirm it is ready before rollout.
5. Add an `HTTPRoute` only when the application needs web access; review the access boundary.
6. Select storage class, reclaim policy, backup group, and recovery procedure before deploying stateful data.
7. Update this table and the relevant reference/runbook in the same change.
