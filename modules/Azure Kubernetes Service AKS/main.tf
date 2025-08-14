# Create AKS clusters dynamically
resource "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.aks_clusters
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = each.value.node_count
    vm_size    = each.value.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = each.value.environment
  }
}

# Output client certificate for each cluster
output "client_certificate" {
  value = {
    for name, cluster in azurerm_kubernetes_cluster.aks :
    name => cluster.kube_config[0].client_certificate
  }
  sensitive = true
}

# Output raw kubeconfig for each cluster
output "kube_config_raw" {
  value = {
    for name, cluster in azurerm_kubernetes_cluster.aks :
    name => cluster.kube_config_raw
  }
  sensitive = true
}