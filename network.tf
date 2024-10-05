resource "azurerm_virtual_network" "base" {
  name                = var.azurerm_virtual_network.name
  resource_group_name = azurerm_resource_group.base.name
  address_space       = var.azurerm_virtual_network.address_space
  location            = azurerm_resource_group.base.location


}

resource "azurerm_subnet" "base" {
  count                = length(var.azurerm_subnet_info)
  name                 = var.azurerm_subnet_info[count.index].name
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.base.name
  address_prefixes     = var.azurerm_subnet_info[count.index].address_prefixes

}



resource "azurerm_network_security_group" "base" {
  name                = var.web_security.name
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location

}

resource "azurerm_network_security_rule" "web" {
  count                       = length(var.web_security.rules)
  name                        = var.web_security.rules[count.index].name
  resource_group_name         = azurerm_resource_group.base.name
  network_security_group_name = azurerm_network_security_group.base.name
  priority                    = var.web_security.rules[count.index].priority
  direction                   = var.web_security.rules[count.index].direction
  access                      = var.web_security.rules[count.index].access
  protocol                    = var.web_security.rules[count.index].protocol
  source_port_range           = var.web_security.rules[count.index].source_port_range
  destination_port_range      = var.web_security.rules[count.index].destination_port_range
  source_address_prefix       = var.web_security.rules[count.index].source_address_prefix
  destination_address_prefix  = var.web_security.rules[count.index].destination_address_prefix
  depends_on                  = [azurerm_network_security_group.base]

}

resource "azurerm_network_security_rule" "app" {
  count                       = length(var.app_security.rules)
  name                        = var.app_security.rules[count.index].name
  resource_group_name         = azurerm_resource_group.base.name
  network_security_group_name = azurerm_network_security_group.base.name
  priority                    = var.app_security.rules[count.index].priority
  direction                   = var.app_security.rules[count.index].direction
  access                      = var.app_security.rules[count.index].access
  protocol                    = var.app_security.rules[count.index].protocol
  source_port_range           = var.app_security.rules[count.index].source_port_range
  destination_port_range      = var.app_security.rules[count.index].destination_port_range
  source_address_prefix       = var.app_security.rules[count.index].source_address_prefix
  destination_address_prefix  = var.app_security.rules[count.index].destination_address_prefix
  depends_on                  = [azurerm_network_security_group.base]
}


resource "azurerm_public_ip" "public_ip" {
  name                = var.azurerm_public_ip.name
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name
  allocation_method   = var.azurerm_public_ip.allocation_method

  tags = {
    environment = "development"
  }
}



resource "azurerm_network_interface" "base" {
  count               = length(var.azurerm_network_interface)
  name                = var.azurerm_network_interface[count.index].name
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  ip_configuration {
    name                          = var.azurerm_network_interface[count.index].ip_configuration.name
    subnet_id                     = azurerm_subnet.base[count.index].id
    private_ip_address_allocation = var.azurerm_network_interface[count.index].ip_configuration.private_ip_address_allocation
    
  }

}

resource "azurerm_linux_virtual_machine" "base" {
  count               = length(var.public_servers)
  name                = var.public_servers[count.index].name
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  size                = var.public_servers[count.index].size
  disable_password_authentication = false
  source_image_reference {
    publisher = var.public_servers[count.index].source_image_reference.publisher
    offer     = var.public_servers[count.index].source_image_reference.offer
    sku       = var.public_servers[count.index].source_image_reference.sku
    version   = var.public_servers[count.index].source_image_reference.version
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_username = var.public_servers[count.index].admin_username
  admin_password = var.public_servers[count.index].admin_password

  network_interface_ids = [azurerm_network_interface.base[count.index].id]
  depends_on            = [azurerm_network_interface.base]

}