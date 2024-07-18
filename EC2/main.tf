terraform {
required_version = ">= 1.2.0"
//backend "local" {
  //  path = "terraform.tfstate"
 // }
cloud {
     organization = "Hackathon2024"
      
      workspaces {
      name = "TF-AWS-Instance"
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


resource "aws_instance" "mytest" {
  ami = data.aws_ami.ami.id
  //ami = "ami-0ab23052532f168a5"
  instance_type = "t2.micro"

  tags = {
    Name = var.ec2name
  }

}

output "private_ip_address" {
value = aws_instance.mytest.private_ip
depends_on = [aws_instance.mytest]
}
