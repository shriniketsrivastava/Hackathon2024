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
    aws = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
}
provider "azurerm" {
  #profile = "LSCInfraAWSAdmin-194884354514"
  region = "us-east-1"
}
module "azure_image" {
  source = "./modules/packer_module"

  client_id = var.client_id
  client_secret = var.client_secret 
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  image_sku = var.image_sku
  image_offer = var.image_offer
  image_publisher = var.image_publisher
  managed_image_name = var.managed_image_name
  vm_size = var.vm_size
  os_type = var.os_type
  

}