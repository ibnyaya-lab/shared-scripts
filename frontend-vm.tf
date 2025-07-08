resource "azurerm_network_interface" "nic_frontend" {
  name                = "nic-frontend"
  location            = azurerm_resource_group.rg_test.location
  resource_group_name = azurerm_resource_group.rg_test.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend_public_ip.id
  }
}

resource "azurerm_public_ip" "frontend_public_ip" {
  name                = "pip-frontend"
  location            = azurerm_resource_group.rg_test.location
  resource_group_name = azurerm_resource_group.rg_test.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_linux_virtual_machine" "frontend" {
  name                = "vm-frontend"
  resource_group_name = azurerm_resource_group.rg_test.name
  location            = azurerm_resource_group.rg_test.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic_frontend.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-frontend"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    tier = "frontend"
  }

#  provisioner "remote-exec" {
#    inline = [
#      "sudo apt-get update",
#      "sudo apt-get install -y nginx",
#      "sudo systemctl enable nginx",
#      "sudo systemctl start nginx"
#    ]

#    connection {
#      type        = "ssh"
#      user        = "azureuser"
#      private_key = file("${path.module}/id_rsa")
#      host        = azurerm_public_ip.frontend_public_ip.ip_address
#    }
#  }
}
