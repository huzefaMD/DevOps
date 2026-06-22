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

  tenant_id = "-----"
  subscription_id = "-----------"
  client_id = "-------------"
  client_secret = "------------"
  
}

variable "environment" {
    type = string
    description = "the env type"
    default = "staging"
  
}

locals {
  resource_group_name = "TFRG"
  location = "East US"
  storage_account_name = "tfsa1030"
}

#This block to create resource gorup

resource "azurerm_resource_group" "TFRG" {
  name     = local.resource_group_name
  location = local.location
}

#this block to create storage account

resource "azurerm_storage_account" "TFSA" {
  name                     = local.storage_account_name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "var.environment"
  }
  depends_on = [ azurerm_resource_group.TFRG ]
}

#This block to create a container in Storage Account

resource "azurerm_storage_container" "TFCO" {
  name                  = "data"
  storage_account_name  = local.storage_account_name
  container_access_type = "private"

  depends_on = [ azurerm_storage_account.TFSA ]
}


#This block to upload a file from local pc to azure SA

resource "azurerm_storage_blob" "TFBLOB" {
  name                   = "main.tf"
  storage_account_name   = local.storage_account_name
  storage_container_name = "data"
  type                   = "Block"
  source                 = "C:/azure1030/main.tf"
depends_on = [ azurerm_storage_container.TFCO ]
}


output "storage_account_name" {
    value = azurerm_storage_account.TFSA.name
   
}
