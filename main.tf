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

data "aws_ami" "ami" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "name"
    values = [var.aminame]
  }
}

output "ami_id" {
  value = data.aws_ami.ami.id
}

resource "aws_instance" "mytest" {
  ami = data.aws_ami.ami.id
  //ami = "ami-0ab23052532f168a5"
  instance_type = "t2.micro"

  tags = {
    Name = "Hackathon"
  }

}




