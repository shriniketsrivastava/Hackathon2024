packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}


variable "aminame" {
  type    = string
  default = ""
}

variable "base_ami" {
  type    = string
  default = ""
}

variable "triggered_user" {
  type    = string
  default = ""
}

source "amazon-ebs" "aws_ami" {
  ami_block_device_mappings {
    delete_on_termination = "true"
    device_name           = "/dev/sdb"
    encrypted             = "false"
    iops                  = "600"
    volume_size           = "200"
    volume_type           = "gp2"
  }
  ami_description = "AWS golden image built by packer"
  ami_name        = "${var.aminame}"
  instance_type   = "t3a.xlarge"
  launch_block_device_mappings {
    delete_on_termination = "true"
    device_name           = "/dev/xvda"
    encrypted             = "false"
    iops                  = "600"
    volume_size           = "200"
    volume_type           = "gp2"
  }
  region       = "us-east-1"
  source_ami   = "${var.base_ami}"
  ssh_username = "ec2-user"
  subnet_id    = "subnet-0adc620a49bfde3f3"
  tags = {
    BuiltBy   = "Packer"
    CreatedBy = "${var.triggered_user}"
    Name      = "${var.aminame}"
  }
  vpc_id = "vpc-052e92c38d2f0b259"
}


build {
  sources = ["source.amazon-ebs.aws_ami"]

  provisioner "shell" {
   // scripts = ["scripts/Java_Install.sh", "scripts/InstallJava17.sh", "scripts/Firefox_Install.sh", "scripts/docker.sh", "scripts/Chrome_Install.sh", "scripts/Teamcity_Install.sh", "scripts/install-aws-cli.sh", "scripts/install-Git.sh"]
   inline = ["sudo yum install -y git"]
  }
  post-processor "manifest" { 
    output = ".manifest.json"
    strip_path = true
  }
  post-processor "shell-local" { 
    inline = [
      "jq -r '.builds[-1].artifact_id | split(":") | .[1]' manifest.json > .image_version"
    ]

}

}
