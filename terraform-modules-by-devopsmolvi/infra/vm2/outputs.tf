output "vm_name" {
  value = azurerm_virtual_machine.vm.name
}

output "vm_public_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}
