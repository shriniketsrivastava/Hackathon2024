terraform {
required_version = ">= 1.2.0"
//backend "local" {
  //  path = "terraform.tfstate"
 // }
cloud {
     organization = "Hackathon2024"
      
      workspaces {
      name = "TF-Hackathon-AWS"
      project = "Default Project"
    }
    }
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
data "local_file" "image_version" {
  filename = "${path.module}/packer/.image_version"
  depends_on = [ module.aws_image ]
}
output "image_name" {
  value = data.local_file.image_version.content
 depends_on = [ module.aws_image ]
}





