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

  tenant_id = ""
  subscription_id = ""
  client_id = ""
  client_secret = ""
  
}

locals {
  resource_group_name = "tf-rg"
  location = "East US"
  virtual_network_name = "tf-vnet"
  azurerm_network_security_group = "tf-nsg"
  azurerm_windows_virtual_machine = "tf-vm"
  azurerm_public_ip = "tf-pubip"

}




#This block to creat Resouce Group

resource "azurerm_resource_group" "TFRG" {
  name     = local.resource_group_name
  location = local.location
}

#This block to create a Vnet and a subnet


resource "azurerm_virtual_network" "tfvnet" {
  name                = local.virtual_network_name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = ["10.0.0.0/16"]

  depends_on = [ azurerm_resource_group.TFRG ]
}

resource "azurerm_subnet" "tfsubnet" {
  name                 = "PublicSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [ azurerm_virtual_network.tfvnet ]
}


#This block to create NSG with a New inbound rule

resource "azurerm_network_security_group" "TFNSG" {
  name                = local.azurerm_network_security_group
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  depends_on = [ azurerm_subnet.tfsubnet ]

}

#NSG and Subnet Association 

resource "azurerm_subnet_network_security_group_association" "nsgsubasso" {
  subnet_id                 = azurerm_subnet.tfsubnet.id
  network_security_group_id = azurerm_network_security_group.TFNSG.id
}

# this block to create a Public IP Address

resource "azurerm_public_ip" "tf-pubip" {
  name                = local.azurerm_public_ip
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"

depends_on = [ azurerm_virtual_network.tfvnet ]

}


# this block to add Network interface

resource "azurerm_network_interface" "tf-nic" {
  name                = "myclassnic"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tfsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf-pubip.id
  }

depends_on = [ azurerm_resource_group.TFRG ]
}


#this block to create a Windows VM

resource "azurerm_windows_virtual_machine" "tfvm" {
  name                = local.azurerm_windows_virtual_machine
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_D4s_v3"
  admin_username      = "Huzefa"
  admin_password      = "abc@12345678"
  network_interface_ids = [
    azurerm_network_interface.tf-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

depends_on = [ azurerm_subnet_network_security_group_association.nsgsubasso ]
}

output "tfvm" {
  value = azurerm_windows_virtual_machine.tfvm
  sensitive = true
  
}

output "tf-pubip" {
  value = azurerm_public_ip.tf-pubip

}
