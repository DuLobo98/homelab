# Homelab Documentation

This documentation serves as a comprehensive guide for my personal homelab, detailing its setup, configuration, and maintenance. It aims to ensure reproducibility, facilitate troubleshooting, and document best practices for a robust home IT environment.

## Folder Structure

```
homelab/
├── infrastructure/                                # Infrastructure as Code
│   └── proxmox/                                   # Proxmox Infrastructure
├── kubernetes/                                    # Kubernetes cluster manifests
│   └── argocd/                                    # ArgoCD manifests
│       └── apps/                                  # ArgoCD applications (See Kubernetes Applications section)
├── scripts/                                       # Utility scripts
├── Taskfile.yaml                                  # Task automation
```

## Bootstrap Process

This section documents the full bootstrap process from tools installation to infrastructure provisioning and Kubernetes apps deployment.

### 1. Prerequisites

The tools required to manage the infrastructure and cluster are defined in `mise.toml` that is used to manage tool versions. Along with `op` (1Password CLI) that is used to inject secrets into the infrastructure that is not included in the mise file because comes from the windows system directly.


### 2. Infrastructure

Infrastructure is provisioned on Proxmox Virtual Environment using Terraform.

#### Secrets Generation
Before running Terraform, generate the necessary variable files from 1Password:

```bash
task op:generate
```

This will inject secrets into `infrastructure/proxmox/*.tfvars` files.

#### Provisioning VMs
Navigate to the Proxmox infrastructure directory and apply the configuration:

```bash
cd infrastructure/proxmox
terraform init
terraform apply -var-file="local.tfvars" # When running locally
terraform apply -var-file="tailscale.tfvars" # When running remotely
```

This will create the following VMs:
- `k8s-prod-control-plane-01` (192.168.1.200)
- `k8s-prod-worker-01` (192.168.1.201)
- `k8s-prod-worker-02` (192.168.1.202)

### 3. Kubernetes Cluster Setup

Once the VMs are up and running, bootstrap the K3s cluster with 1 control plane and 2 worker nodes:

```bash
task k3s:bootstrap
```

This task will:
1. Install K3s on the control plane.
2. Retrieve the node token.
3. Join the worker nodes to the cluster.
4. Copy the `kubeconfig` to your local machine (`~/.kube/config-k3s`).

### 4. Kubernetes Apps Bootstrap

Finally, bootstrap ArgoCD and the initial set of applications:

```bash
task k8s:bootstrap
```

This will:
1. Create the `external-secrets` namespace and configure 1Password token for external-secrets.
2. Install ArgoCD using Kustomize with Helm
3. Wait for ArgoCD to be ready
4. Display the initial admin password

ArgoCD will automatically sync all applications from the `kubernetes/argocd/apps/` directory.

### Sync Waves

Applications are deployed in order using `argocd.argoproj.io/sync-wave` annotations to ensure dependencies are ready before dependent applications are deployed:

| Wave  | Applications             | Purpose                                                                     |
|-------|--------------------------|-----------------------------------------------------------------------------|
| **0** | ArgoCD, external-secrets | Core infrastructure that other apps depend on                               |
| **1** | cert-manager             | Is dependent on external-secrets                                            |

### Kubernetes Applications

All applications are deployed using ArgoCD's app of apps pattern, where a root application manages the deployment of all other applications within the cluster, ensuring a consistent and declarative approach to infrastructure and application management.

#### Core Services

| Application      | Namespace        | URL                                    | Description                          |
|------------------|------------------|----------------------------------------|--------------------------------------|
| ArgoCD           | argocd           | https://argocd.home.lobotechworks.pt   | GitOps CD for Kubernetes             |
| cert-manager     | cert-manager     | -                                      | Automated TLS certificate management |
| external-secrets | external-secrets | -                                      | Sync secrets from 1Password          |

#### Applications

| Application      | Namespace        | URL                                    | Description                          |
|------------------|------------------|----------------------------------------|--------------------------------------|

## Machine IPs

|          Machine Name           |   IP Address   |               Purpose               |
|---------------------------------|----------------|-------------------------------------|
| pve-01                          | 192.168.1.100  | Proxmox Virtual Environment         |
| pbs-01                          | 192.168.1.101  | Proxmox Backup Server               |
| k8s-prod-control-plane-01       | 192.168.1.200  | Kubernetes Control Plane - Prod     |
| k8s-prod-worker-01              | 192.168.1.201  | Kubernetes Worker - Prod            |
| k8s-prod-worker-02              | 192.168.1.202  | Kubernetes Worker - Prod            |
