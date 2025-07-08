resource "azurerm_private_dns_zone" "postgresql_dns" {
  name                = "postgresqlflex.private.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg_test.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "link-postgresql"
  private_dns_zone_name = azurerm_private_dns_zone.postgresql_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.rg_test.name

  depends_on = [azurerm_subnet.database]
}

resource "azurerm_postgresql_flexible_server" "db_flexible_server" {
  name                          = "pg-flex-server"
  resource_group_name           = azurerm_resource_group.rg_test.name
  location                      = azurerm_resource_group.rg_test.location
  version                       = "12"
  delegated_subnet_id           = azurerm_subnet.database.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgresql_dns.id

  administrator_login           = "pgadmin"
  administrator_password        = var.pg_password

  storage_mb                    = 32768
  storage_tier                  = "P4"

  sku_name                      = "B_Standard_B1ms"

  zone                          = "2"  # <-- Ajoute cette ligne ici

  depends_on = [azurerm_private_dns_zone_virtual_network_link.vnet_link]
}

resource "azurerm_postgresql_flexible_server_database" "mydb" {
  name      = "mydb"
  server_id = azurerm_postgresql_flexible_server.db_flexible_server.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
