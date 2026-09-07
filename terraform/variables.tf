variable "location" {
  description = "Azure region for the Terraform-managed infrastructure"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the Terraform-managed resource group"
  type        = string
  default     = "rg-azure-iac-lab"
}

variable "vnet_name" {
  description = "Name of the Terraform-managed virtual network"
  type        = string
  default     = "vnet-azure-iac-lab"
}

variable "vnet_address_space" {
  description = "Address space for the Terraform-managed virtual network"
  type        = list(string)
  default     = ["10.40.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the Terraform-managed subnet"
  type        = string
  default     = "subnet-azure-iac-lab"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the Terraform-managed subnet"
  type        = list(string)
  default     = ["10.40.1.0/24"]
}