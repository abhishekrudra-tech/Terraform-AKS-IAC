terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.36.0"
    }
  }

  backend "azurerm" {
    use_cli              = true                                    
    use_azuread_auth     = true                                    
    tenant_id            = "eb5c877f-d806-4ea9-a2fc-bfabb3599331"                                    
    storage_account_name = "statemanagement2025" 
    # resource_gresource_group_name = "terraform-rg"                             
    container_name       = "tfstate"                               
    key                  = "prod.terraform.tfstate"                
  }
}


provider "azurerm" {
  features {}
  subscription_id = "6eb6ee21-8952-4718-9243-5a0101ee200e"
}