terraform {
  backend "azurerm" {
    storage_account_name = "sttfstatejk97312869"
    container_name       = "tfstate"
    key                  = "azure-iac-lab.tfstate"

    use_azuread_auth = true
    use_cli          = true
  }
}