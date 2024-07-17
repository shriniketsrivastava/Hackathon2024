data "local_file" "image_version" {
  filename = "${path.module}/packer/.image_version"
  depends_on = [ terraform_data.packer_template ]
}
output "image_name" {
  value = data.local_file.image_version.content
}
resource "aws_instance" "mytest" {
  ami = module.aws_image.image_name
  //ami = "ami-0ab23052532f168a5"
  instance_type = "t2.micro"

  tags = {
    Name = "Hackathon"
  }
}
