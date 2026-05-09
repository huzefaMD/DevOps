terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "stateRG"
      storage_account_name = "statestore4526"
      container_name       = "tfstate"
      key                  = "dev.terraform.tfstate"
  }
}


provider "azurerm" {
 features {
   
 }

  tenant_id = "7--------------------
  subscription_id = "9--------------------------"
  client_id = "0--------------------------------"
  client_secret = "8----------------------"
  
}

#This block to create resource gorup

resource "azurerm_resource_group" "example" {
  name     = "TFRG"
  location = "East US"
}

#This block to create Storage account

resource "azurerm_storage_account" "example" {
  name                     = "mystorageclass"
  resource_group_name      = "TFRG"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  depends_on = [ azurerm_resource_group.example ]

  tags = {
    environment = "staging"
  }
}

#This block to create a new container in the storage account

resource "azurerm_storage_container" "TFBlob" {
  name                  = "docs"
  storage_account_name  = "mystorageclass"
  container_access_type = "private"
  depends_on = [ azurerm_storage_account.example ]
}

#Upload a file in storage container

resource "azurerm_storage_blob" "TFFile" {
  name                   = "main.tf"
  storage_account_name   = "mystorageclass"
  storage_container_name = "docs"
  type                   = "Block"
  source                 = "c:/azuretf/main.tf"
  depends_on = [ azurerm_storage_container.TFBlob ]
}
