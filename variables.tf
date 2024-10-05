
variable "azurerm_resource_group" {
  type = object({
    name     = string
    location = string
  })

}

variable "azurerm_virtual_network" {
  type = object({
    name          = string
    address_space = list(string)
  })

}

variable "azurerm_subnet_info" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))

}

variable "web_security" {
  type = object({
    name = string
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string

    }))
  })

}

variable "app_security" {
  type = object({
    name = string
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string

    }))
  })

}


variable "azurerm_public_ip" {
  type = object({
    name              = string
    allocation_method = string
  })

}

variable "azurerm_network_interface" {
  type = list(object({
    name = string
    ip_configuration = object({
      name                          = string
      private_ip_address_allocation = string
    })
  }))

}


variable "public_servers" {
  type = list(object({
    name = string
    size = string
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    admin_username = string
    admin_password = string
  }))

}

