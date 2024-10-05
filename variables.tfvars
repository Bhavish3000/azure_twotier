azurerm_resource_group = {
  name     = "two_tier"
  location = "East US"
}

azurerm_virtual_network = {
  name          = "two_tier_vnet"
  address_space = ["192.168.0.0/16"]
}

azurerm_subnet_info = [
  {
    name             = "web"
    address_prefixes = ["192.168.0.0/24"]
  },
  {
    name             = "db"
    address_prefixes = ["192.168.1.0/24"]
  }
]

web_security = {
  name = "web_nsg"
  rules = [{
    name                       = "openssh"
    priority                   = 300
    direction                  = "Inbound"
    protocol                   = "Tcp"
    access                     = "Allow"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    }, {
    name                   = "openhttp"
    priority               = 350
    direction              = "Inbound"
    protocol               = "Tcp"
    access                 = "Allow"
    source_port_range      = "*"
    destination_port_range = "80"
    source_address_prefix  = "*"
    destination_address_prefix = "*" },
    { name                   = "openhttps"
      priority               = 400
      direction              = "Inbound"
      protocol               = "Tcp"
      access                 = "Allow"
      source_port_range      = "*"
      destination_port_range = "443"
      source_address_prefix  = "*"
  destination_address_prefix = "*" }]
}

app_security = {
  name  = "app_nsg"
  rules = []
}



azurerm_public_ip = {
  name              = "publicip"
  allocation_method = "Static"
}

azurerm_network_interface = [{
  name = "public_ni"
  ip_configuration = {
    name                          = "web_privateip"
    private_ip_address_allocation = "Dynamic"
  }

  },
  {
    name = "Private_ni"
    ip_configuration = {
      name                          = "app_privateip"
      private_ip_address_allocation = "Dynamic"
    }
}]

public_servers = [{
  name = "webserver"
  size = "Standard_B1s"
  source_image_reference = {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  admin_username = "BHAVISH"
  admin_password = "Sist@6302727129"
}]