
resource "terraform_data" "packer_template" {

//provisioner "local-exec" {
//command = "sudo mkdir -p /opt/packer"
//}
//provisioner "local-exec" {
//working_dir = "/opt/packer/"
//command = "wget https://releases.hashicorp.com/packer/1.11.0/packer_1.11.0_linux_amd64.zip"
//}
provisioner "local-exec" {
command = "ls -al /opt/packer_new"
}
//provisioner "local-exec" {
//command = "sudo apt install -y unzip"
//}
//provisioner "local-exec" {
//working_dir = "/opt/packer/"
//command = "unzip -o packer_1.11.0_linux_amd64.zip"
//}
provisioner "local-exec" {
command = "sudo /opt/packer_new/packer plugins install github.com/hashicorp/amazon"
}
provisioner "local-exec" {
   
    working_dir = "${path.module}/packer/"
    command     = "/opt/packer_new/packer build -var aminame=${var.aminame} -var base_ami=${var.base_ami} -var triggered_user=${var.triggered_user} packer.pkr.hcl"
  }
 

}
