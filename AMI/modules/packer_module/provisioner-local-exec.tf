
resource "terraform_data" "packer_template" {
triggers_replace = [local.packer_contents_hash]

provisioner "local-exec" {
command = "mkdir -p /opt/packer"
}
provisioner "local-exec" {
working_dir = "/opt/packer/"
command = "wget https://releases.hashicorp.com/packer/1.11.0/packer_1.11.0_linux_amd64.zip"
}
provisioner "local-exec" {
command = "ls -al /opt/packer"
}
provisioner "local-exec" {
command = "apt install -y unzip"
}
provisioner "local-exec" {
working_dir = "/opt/packer/"
command = "unzip -o packer_1.11.0_linux_amd64.zip"
}
provisioner "local-exec" {
command = "/opt/packer/packer plugins install github.com/hashicorp/amazon"
}
provisioner "local-exec" {
    when = create 
    working_dir = "${path.module}/packer/"
    command     = "/opt/packer/packer build -var aminame=${var.aminame} -var base_ami=${var.base_ami} -var triggered_user=${var.triggered_user} packer.pkr.hcl"
  }
 

}

