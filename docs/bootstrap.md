# Bootstrap

This runbook establishes the declared Kubernetes platform. It assumes the Proxmox hosts, private network, DNS reachability, 1Password vault entries, Terraform state backend, and backup target already exist. Those dependencies are outside the scope of this repository.

## Prerequisites

```bash
mise install
op signin
```

The required tool versions are declared in [`mise.toml`](https://github.com/DuLobo98/homelab/blob/main/mise.toml). Do not commit files generated from 1Password templates.

## Provision the control plane

Generate local Terraform variable files from the 1Password templates, then apply the Proxmox configuration:

```bash
task op:generate
cd infrastructure/proxmox
terraform init
terraform apply -var-file="local.tfvars"
```

For remote administration, generate and use the remote variables file as defined by the Terraform templates. Review the plan before applying.

## Bootstrap Kubernetes services

After Talos is healthy, run:

```bash
task k8s:bootstrap
```

This task obtains the Talos client configuration, writes a local kubeconfig, applies Cilium, provides the External Secrets Operator with the 1Password token, installs Argo CD, and starts app-of-apps reconciliation.

## Verify

```bash
kubectl get nodes
kubectl get applications -n argocd
kubectl get httproutes --all-namespaces
kubectl get clustersecretstore onepassword
```

Resolve unhealthy Argo CD applications and a non-ready 1Password store before considering bootstrap complete. Complete the [health checks](operations/health-checks.md) and verify DNS, certificate issuance, Longhorn backup visibility, and alert delivery from an approved internal client.
