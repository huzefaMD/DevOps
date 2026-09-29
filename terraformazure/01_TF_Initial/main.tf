terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
}
provider "azurerm" {
 features {
   
 }

  tenant_id = "******"
  subscription_id = "*********"
  client_id = "********"
  client_secret = "*********"
  
}

#This block to create resource gorup

resource "azurerm_resource_group" "TFRG" {
  name     = "TFRG"
  location = "East US"
}
