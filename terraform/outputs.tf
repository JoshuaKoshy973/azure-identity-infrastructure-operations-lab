output "resource_group_name" {
  description = "Name of the Terraform-managed resource group"
  value       = azurerm_resource_group.iac_rg.name
}

output "vnet_name" {
  description = "Name of the Terraform-managed virtual network"
  value       = azurerm_virtual_network.iac_vnet.name
}

output "subnet_name" {
  description = "Name of the Terraform-managed subnet"
  value       = azurerm_subnet.iac_subnet.name
}