terraform {
required_version = ">= 1.2.0"
 backend "local" {
    path = "terraform.tfstate"
  }
//cloud {
    //  organization = "Hackathon2024"
      
     // workspaces {
     // name = "Hackathon2024"
     // project = "Default Project"
    //}
   // }
required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16.0"
    }
  }
}
provider "aws" {
  #profile = "LSCInfraAWSAdmin-194884354514"
  region = "us-east-1"
}

module "aws_image" {
  source = "./modules/packer_module"

  aminame = var.aminame
  base_ami = var.base_ami 
  triggered_user = var.triggered_user

}

