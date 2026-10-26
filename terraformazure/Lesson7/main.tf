terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.69.0"
    }
  }
}

  # backend "azurerm" {
  #   resource_group_name  = "RGtftstatetest"
  #   storage_account_name = "tftstatefileteststorage"
  #   container_name       = "mystatefilecontainer"
  #   key                  = "backup.terraform.tfstate"
  # }

provider "azurerm" {
 features {   
 }

  tenant_id = ""
  subscription_id = ""
  client_id = ""
  client_secret = ""
}

variable "environment" {
  type    = string
  description = "The environment for the resources for Storage Account"
  default = "production"
}

locals {
  location             = "WEST US"
  resource_group_name  = "TFRGwest"
  storage_account_name = "tfsa1030est"
  vnet_name           = "TFVNet"
  windows_subnet_name = "windowssubnet"
  linux_subnet_name   = "linuxsubnet"
}


resource "azurerm_resource_group" "TFRG" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_storage_account" "TFSA" {
  name                     = local.storage_account_name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "staging"
  }
  depends_on = [azurerm_resource_group.TFRG]
}


resource "azurerm_storage_container" "TFCO" {
  name                  = "data"
  storage_account_name = local.storage_account_name
  container_access_type = "private"
 depends_on = [azurerm_storage_account.TFSA]
}

resource "azurerm_storage_blob" "TFBLOB" {
  name                   = "providers.tf"
  storage_account_name   = local.storage_account_name
  storage_container_name = "data"
  type                   = "Block"
  source                 = "E:/azureterraform/providers.tf"
  depends_on = [azurerm_storage_container.TFCO]
}

resource "azurerm_virtual_network" "TFVNET" {
  name                = local.vnet_name
  address_space       = ["10.10.0.0/16"]
  location            = local.location
  resource_group_name = local.resource_group_name
  depends_on = [azurerm_resource_group.TFRG]
}

resource "azurerm_subnet" "WINDOWSSUBNET" {
  name                 = local.windows_subnet_name
  resource_group_name  = azurerm_resource_group.TFRG.name
  virtual_network_name = azurerm_virtual_network.TFVNET.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "LINUXSUBNET" {
  name                 = local.linux_subnet_name
  resource_group_name  = azurerm_resource_group.TFRG.name
  virtual_network_name = azurerm_virtual_network.TFVNET.name
  address_prefixes     = ["10.10.2.0/24"]
}

resource "azurerm_network_security_group" "WINDOWSNSG" {
  name                = "windows-nsg"
  location            = local.location
  resource_group_name = azurerm_resource_group.TFRG.name
  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "LINUXNSG" {
  name                = "linux-nsg"
  location            = local.location
  resource_group_name = azurerm_resource_group.TFRG.name
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "WINDOWSASSOCIATION" {
  subnet_id                 = azurerm_subnet.WINDOWSSUBNET.id
  network_security_group_id = azurerm_network_security_group.WINDOWSNSG.id
}

resource "azurerm_subnet_network_security_group_association" "LINUXASSOCIATION" {
  subnet_id                 = azurerm_subnet.LINUXSUBNET.id
  network_security_group_id = azurerm_network_security_group.LINUXNSG.id
}

resource "azurerm_public_ip" "WINDOWSPIP" {
  name                = "windows-public-ip"
  resource_group_name = azurerm_resource_group.TFRG.name
  location            = local.location
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "LINUXPIP" {
  name                = "linux-public-ip"
  resource_group_name = azurerm_resource_group.TFRG.name
  location            = local.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "WINDOWSNIC" {
  name                = "windows-nic"
  location            = local.location
  resource_group_name = azurerm_resource_group.TFRG.name
  ip_configuration {
    name                          = "windows-ipconfig"
    subnet_id                     = azurerm_subnet.WINDOWSSUBNET.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.WINDOWSPIP.id
  }
}

resource "azurerm_network_interface" "LINUXNIC" {
  name                = "linux-nic"
  location            = local.location
  resource_group_name = azurerm_resource_group.TFRG.name
  ip_configuration {
    name                          = "linux-ipconfig"
    subnet_id                     = azurerm_subnet.LINUXSUBNET.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.LINUXPIP.id
  }
}

output "public_ip_windows" {
  value = azurerm_public_ip.WINDOWSPIP.ip_address
}
output "public_ip_linux" {
  value = azurerm_public_ip.LINUXPIP.ip_address
}

output "windows_nic_id" {
  value = azurerm_network_interface.WINDOWSNIC.id
}
output "linux_nic_id" {
  value = azurerm_network_interface.LINUXNIC.id
}
output "windows_nsg_id" {
  value = azurerm_network_security_group.WINDOWSNSG.id
}
output "linux_nsg_id" {
  value = azurerm_network_security_group.LINUXNSG.id
}
output "windows_subnet_id" {
  value = azurerm_subnet.WINDOWSSUBNET.id
}
output "linux_subnet_id" {
  value = azurerm_subnet.LINUXSUBNET.id
}
