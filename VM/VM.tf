terraform {
required_version = ">= 1.2.0"
//backend "local" {
  //  path = "terraform.tfstate"
 // }
cloud {
     organization = "Hackathon2024"
      
      workspaces {
      name = "TF-AZ-Hackathon"
      project = "Default Project"
    }
    }
required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
}

provider "azurerm" {
  #profile = "LSCInfraAWSAdmin-194884354514"
  
  features {}
}


resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  numeric = false
}

resource "azurerm_virtual_network" "vn" {
  name                = "hack-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = local.tags
}

resource "azurerm_subnet" "sn" {
  name                 = "hack-subnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "hack" {
  name                = "hack-nic"
  location            = var.location
  resource_group_name = local.resource_group_name
  ip_configuration {
    name                          = "hackconfig"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
  }
  tags                = local.tags
}



data "azurerm_image" "image" {
  name                = var.managed_image_name
  resource_group_name = local.resource_group_name
}



resource "azurerm_virtual_machine" "test" {
  name                  = "hacker-vm"
  location              = "${var.location}"
  resource_group_name   = local.resource_group_name
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${azurerm_network_interface.hack.id}"]

  storage_image_reference {
    id = "${data.azurerm_image.image.id}"
  }

  storage_os_disk {
    name          = "hacker-vm-osdisk"
    create_option = "FromImage"
    disk_size_gb  = "30"
  }

  os_profile {
    computer_name  = "hacker-vm"
    admin_username = "aperio"
    admin_password = "Sc@nscope123"
  }

   os_profile_windows_config {
    enable_automatic_upgrades = true
  }
}