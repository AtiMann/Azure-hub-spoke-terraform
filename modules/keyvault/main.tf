data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length = 4
  special =false 
  upper = false
}
resource "azurerm_key_vault" "kv" {
  location = var.location
  name = "${var.name_prefix}-${random_string_suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization = true

  soft_delete_retention_days = 1
  purge_protection_enabled = false
  
}
resource "azurerm_role_assignment" "kv_admin" {
    principal_id = azurerm_client_config.current.objectid
    scope = azurerm_key_vault.kv.id
    role_definition_name = "Key vault administrator"
    
}