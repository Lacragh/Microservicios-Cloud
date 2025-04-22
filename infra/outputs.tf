output "public_ips" {
  value = [
    for vm in azurerm_linux_virtual_machine.my_terraform_vm : vm.public_ip_address
  ]
}
