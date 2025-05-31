#!/bin/bash

# From https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
function install_kubectl() {
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl gnupg
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
    sudo apt update
    sudo apt install -y kubectl
}

# From https://helm.sh/docs/intro/install/#from-script
function install_helm() {
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
}

# From https://developer.hashicorp.com/terraform/install#linux
function install_terraform() {
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt install terraform
}

install_kubectl
install_helm
install_terraform

# Clean up apt cache
sudo apt clean && rm -rf /var/lib/apt/lists/*