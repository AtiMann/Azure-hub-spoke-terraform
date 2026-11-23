output "vm_principal_id" {
  value = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}
output "vm_private_ip" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}