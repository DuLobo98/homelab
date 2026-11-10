# External Secrets store unavailable

**Alert:** `ExternalSecretsOnePasswordStoreNotReady`

This alert fires when the `onepassword` ClusterSecretStore has not been ready for five minutes.

```bash
kubectl get clustersecretstore onepassword
kubectl describe clustersecretstore onepassword
kubectl get externalsecret --all-namespaces
kubectl logs -n external-secrets deploy/external-secrets --since=30m
```

Confirm that the 1Password service-account token exists in the `external-secrets` namespace and that the provider can reach 1Password. Do not print, copy, or rotate a token in incident output. Once the store is ready, check affected `ExternalSecret` resources until they report successful synchronization.
