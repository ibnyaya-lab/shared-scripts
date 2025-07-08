resource "azurerm_network_security_group" "nsg_database" {
  name                = "nsg-database"
  location            = azurerm_resource_group.rg_test.location
  resource_group_name = azurerm_resource_group.rg_test.name

  security_rule {
    name                       = "AllowPostgresFromBackend"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "*" # subnet backend
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "database_assoc" {
  subnet_id                 = azurerm_subnet.database.id
  network_security_group_id = azurerm_network_security_group.nsg_database.id
}
