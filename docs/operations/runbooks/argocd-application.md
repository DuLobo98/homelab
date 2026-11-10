# Argo CD application failure

Use this runbook for an Argo CD sync failure or an application health-degraded notification.

```bash
kubectl get applications.argoproj.io -n argocd
kubectl describe application <application> -n argocd
kubectl get events -n <application-namespace> --sort-by=.lastTimestamp
```

Review the Application conditions and the rendered resource that is unhealthy. Correct desired state in Git for configuration errors. If the cause is an unavailable dependency, restore that dependency first; do not repeatedly force sync without identifying the condition.
