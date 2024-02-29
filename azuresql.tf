# Create azure sql database



resource "azurerm_sql_server" "database" {
  name                         = "aks-sql-server"
  resource_group_name          = azurerm_resource_group.aks.name
  location                     = azurerm_resource_group.aks.location
  version                      = "12.0"
  administrator_login          = var.dbUser
  administrator_login_password = var.dbPasswd
}

resource "azurerm_sql_database" "database" {
  name                = "aks-sql-database"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  server_name         = azurerm_sql_server.database.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 5
}
