data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}
resource "azurerm_key_vault" "kv" {
  location                      = var.location
  name                          = "${var.name_prefix}-${random_string.suffix.result}"
  resource_group_name           = var.resource_group_name
  sku_name                      = "standard"
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = true
  enable_rbac_authorization     = true

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

}
resource "azurerm_role_assignment" "kv_admin" {
  principal_id         = data.azurerm_client_config.current.object_id
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"

}
resource "azurerm_private_endpoint" "kv_pe" {
  location            = var.location
  name                = "pe-${azurerm_key_vault.kv.name}"
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  private_service_connection {
    is_manual_connection           = false
    name                           = "psc-${azurerm_key_vault.kv.name}"
    subresource_names              = ["vault"]
    private_connection_resource_id = azurerm_key_vault.kv.id

  }
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.private_dns_zone_ids]
  }

}