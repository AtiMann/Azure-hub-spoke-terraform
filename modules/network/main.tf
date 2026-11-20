resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.address_space
  
}
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name = each.key
  address_prefixes = each.value.address_prefixes
}
resource "azurerm_network_security_group" "sec-group" {
  for_each = {for k, v in var.subnets : k => v if v.create_nsg}
  name = "sec_group-${each.key}"
  resource_group_name = var.resource_group_name
  location = var.location
  dynamic "security_rule" {
    for_each = each.value.nsg_rules
    content {
      name = security_rule.value.name
      priority = security_rule.value.priority
      direction = security_rule.value.direction
      access = security_rule.value.access
      protocol = security_rule.value.protocol
      source_port_range = security_rule.value.source_port_range
      destination_port_range = security_rule.value.destination_port_range
      source_address_prefix = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  
  }
  }
  resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
    for_each = azurerm_network_security_group.sec-group
    network_security_group_id = each.value.id
    subnet_id = azurerm_subnet.subnet[each.key].id
    
  }

  
