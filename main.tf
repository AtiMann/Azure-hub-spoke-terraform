resource "azurerm_resource_group" "rg" {
  name = var.rg_name
  location = var.location
}
module "hub_network" {
  source = "./modules/network"

    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    vnet_name = "vnet-hub"
    address_space = var.hub_address_space
    subnets = var.hub_subnets
}
module "spoke_dev_network" {
  source = "./modules/network"

    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    vnet_name = "vnet-spoke-dev"
    address_space = var.spoke_dev_address_space
    subnets = var.spoke_dev_subnets
}