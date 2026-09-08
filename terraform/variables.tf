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

variable "app_subnet_name" {
  description = "Name of the application subnet"
  type        = string
  default     = "subnet-azure-iac-apps"
}

variable "app_subnet_address_prefixes" {
  description = "Address prefixes for the application subnet"
  type        = list(string)
  default     = ["10.40.2.0/24"]
}

variable "operations_subnet_name" {
  description = "Name of the operations subnet"
  type        = string
  default     = "subnet-azure-iac-operations"
}

variable "operations_subnet_address_prefixes" {
  description = "Address prefixes for the operations subnet"
  type        = list(string)
  default     = ["10.40.3.0/24"]
}

variable "management_subnet_name" {
  description = "Name of the management subnet"
  type        = string
  default     = "subnet-azure-iac-management"
}

variable "management_subnet_address_prefixes" {
  description = "Address prefixes for the management subnet"
  type        = list(string)
  default     = ["10.40.4.0/24"]
}