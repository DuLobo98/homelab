# Health checks

Run these checks after a change, after an outage, and before an invasive operation. They inspect current state unless explicitly stated otherwise.

## Control plane and GitOps

```bash
kubectl get nodes
kubectl get pods --all-namespaces --field-selector=status.phase!=Running,status.phase!=Succeeded
kubectl get applications.argoproj.io -n argocd
kubectl get externalsecret --all-namespaces
kubectl get clustersecretstore onepassword
```

Expected state: all three nodes are `Ready`; Argo CD applications are `Synced` and `Healthy`; required ExternalSecrets are `SecretSynced`; the `onepassword` ClusterSecretStore is `Ready`.

## Traffic, DNS, and TLS

```bash
kubectl get gateway -n traefik
kubectl get httproute --all-namespaces
kubectl get svc -A --field-selector spec.type=LoadBalancer
```

Validate service access from an approved internal client, not from a privileged cluster shell. For a routing failure, check the relevant `HTTPRoute` `Accepted` and `ResolvedRefs` conditions before changing Traefik.

## Storage and monitoring

```bash
kubectl get storageclass
kubectl get pvc --all-namespaces
kubectl get volumes.longhorn.io -n longhorn-system
kubectl get prometheusrule --all-namespaces
```

Review degraded Longhorn volumes and unbound PersistentVolumeClaims before restarting workloads. Confirm the latest backup and restore-test result through the Longhorn interface before approving a data-risking change.

## Escalation data

Capture current status and relevant controller logs without including secret values:

```bash
kubectl describe application <application> -n argocd
kubectl logs -n argocd deploy/argocd-application-controller --since=30m
kubectl get events -A --sort-by=.lastTimestamp
```
