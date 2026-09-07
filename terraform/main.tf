resource "azurerm_resource_group" "iac_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "lab"
    managed_by  = "terraform"
    purpose     = "iac-cicd-learning"
  }
}

resource "azurerm_virtual_network" "iac_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.iac_rg.location
  resource_group_name = azurerm_resource_group.iac_rg.name
}

resource "azurerm_subnet" "iac_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.iac_rg.name
  virtual_network_name = azurerm_virtual_network.iac_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_subnet" "app_subnet" {
  name                 = var.app_subnet_name
  resource_group_name  = azurerm_resource_group.iac_rg.name
  virtual_network_name = azurerm_virtual_network.iac_vnet.name
  address_prefixes     = var.app_subnet_address_prefixes
}