# Tailscale service sharing

The Tailscale Kubernetes Operator is installed once and creates a private
Tailscale HTTPS endpoint for every deliberately shared Kubernetes Service. It
does not use the subnet router or the shared Traefik LoadBalancer, so a guest
cannot use a shared endpoint to reach other homelab services.

## Access model

Use one Tailscale tag per sharing audience, not one tag per application. This
makes the scope explicit: adding another endpoint to an audience's tag shares
it with that audience only.

## Share another service

Create a `tailscale-ingress.yaml` in that service's Kustomize directory,
include it in `kustomization.yaml`, and add the `tailscale-operator` namespace to that
service's ingress NetworkPolicy. Substitute the service name, namespace, port,
and audience tag:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: <service>
  namespace: <namespace>
  annotations:
    tailscale.com/tags: tag:<audience>
spec:
  ingressClassName: tailscale
  tls:
    - hosts:
        - <service>
  defaultBackend:
    service:
      name: <service>
      port:
        number: <port>
```

The generated endpoint uses the form
`https://<service>.<tailnet>.ts.net`.
