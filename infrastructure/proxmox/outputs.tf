output "k8s_network_details" {
  description = "MAC and IPv4 addresses for each Kubernetes node."
  value = {
    for key in keys(local.k8s_prod_talos) :
    key => {
      mac_address  = module.k8s_prod_talos[key].mac_address
      ipv4_address = local.k8s_prod_talos[key].ipv4_address
    }
  }
}
