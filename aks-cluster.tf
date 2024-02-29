# AKS-CLUSTER
#

# To generate a unique name
resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks" {
  name     = "${random_pet.prefix.id}-rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 8
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin = "azure"
  }

  tags = {
    environment = "production"
  }
}
