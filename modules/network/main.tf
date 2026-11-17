resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.address_space
  
}
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  name = each.key
  address_prefixes = each.value.address_prefixes
}