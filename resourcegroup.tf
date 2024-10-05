resource "azurerm_resource_group" "base" {
  name     = var.azurerm_resource_group.name
  location = var.azurerm_resource_group.location

}