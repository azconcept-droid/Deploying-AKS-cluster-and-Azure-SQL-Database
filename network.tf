# Create a new virtual Network

resource "azurerm_resource_group" "network" {
  name     = "sql-network-rg"
  location = "East US"
}

resource "azurerm_virtual_network" "network" {
  name                = "sql-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.1.0/24"]
}
