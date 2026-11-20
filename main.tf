resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}
module "hub_network" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = "vnet-hub"
  address_space       = var.hub_address_space
  subnets             = var.hub_subnets
}
module "spoke_dev_network" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = "vnet-spoke-dev"
  address_space       = var.spoke_dev_address_space
  subnets             = var.spoke_dev_subnets
}
resource "azurerm_virtual_network_peering" "hub_to_spoke_dev" {
  name                      = "hub_to_spoke_dev"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.hub_network.vnet_name
  remote_virtual_network_id = module.spoke_dev_network.vnet_id
}
resource "azurerm_virtual_network_peering" "spoke_to_hub_dev" {
  name                      = "spoke_to_hub_dev"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = module.spoke_dev_network.vnet_name
  remote_virtual_network_id = module.hub_network.vnet_id

}
module "keyvault" {
  source              = "./modules/keyvault"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name_prefix         = var.name_prefix


}