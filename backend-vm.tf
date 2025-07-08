resource "azurerm_public_ip" "backend_ip" {
  name                = "public-ip-backend"
  location            = azurerm_resource_group.rg_test.location
  resource_group_name = azurerm_resource_group.rg_test.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "nic_backend" {
  name                = "nic-backend"
  location            = azurerm_resource_group.rg_test.location
  resource_group_name = azurerm_resource_group.rg_test.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.backend_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "backend" {
  name                = "vm-backend"
  resource_group_name = azurerm_resource_group.rg_test.name
  location            = azurerm_resource_group.rg_test.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic_backend.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-backend"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    tier = "backend"
  }
}
