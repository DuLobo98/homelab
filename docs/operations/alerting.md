# Alerting

Prometheus sends warning and critical alerts to the configured Discord webhook. Argo CD sends the same destination notifications when an application sync fails or health degrades.

## Response

1. Identify the alert name, namespace, affected resource, and first observed time.
2. Check the current state and recent Kubernetes events.
3. Use the matching runbook before restarting or deleting any resource.
4. Confirm recovery in the originating system and that the alert resolves.
5. Record the change when the response altered configuration or data.

## Runbooks

| Alert or signal | Runbook |
| --- | --- |
| `ExternalSecretsOnePasswordStoreNotReady` | [External Secrets store unavailable](runbooks/external-secrets-store.md) |
| Argo CD sync failed or application health degraded | [Argo CD application failure](runbooks/argocd-application.md) |
| Prometheus warning or critical alert | [Prometheus alert](runbooks/prometheus-alert.md) |
