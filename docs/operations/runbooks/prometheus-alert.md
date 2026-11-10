# Prometheus alert

Use this runbook for a Prometheus warning or critical alert.

Open the alert in Alertmanager or Grafana, identify the Prometheus labels, then inspect the referenced Kubernetes resource. The installed chart supplies additional upstream alerts; use the alert name and labels to find the owning workload before intervening.

```bash
kubectl get events --all-namespaces --sort-by=.lastTimestamp
kubectl get pods --all-namespaces --field-selector=status.phase!=Running,status.phase!=Succeeded
```

For storage alerts, inspect the relevant PersistentVolumeClaim and Longhorn volume before changing a workload. For node or infrastructure alerts, confirm cluster quorum and node readiness before draining or rebooting a host.
