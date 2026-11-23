resource "azurerm_network_interface" "nic" {
  location            = var.location
  name                = "nic-${var.vm_name}"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_linux_virtual_machine" "vm" {
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  location                        = var.location
  name                            = var.vm_name
  network_interface_ids           = [azurerm_network_interface.nic.id]
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "Canonical"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  identity {
    type = "SystemAssigned"
  }

}