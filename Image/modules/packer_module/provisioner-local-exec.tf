
resource "terraform_data" "packer_template" {

triggers_replace = [local.packer_contents_hash, local.image_target_build_params]
  
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
command = "/opt/packer/packer plugins install github.com/hashicorp/azure"
}

provisioner "local-exec" {
    when = create 
    working_dir = "${path.module}/packer/"
    command     = "/opt/packer/packer build -var client_id=${var.client_id} -var client_secret=${var.client_secret} -var subscription_id=${var.subscription_id} -var tenant_id=${var.tenant_id} -var image_sku=${var.image_sku} -var image_offer=${var.image_offer} -var image_publisher=${var.image_publisher} -var managed_image_name=${var.managed_image_name} -var vm_size=${var.vm_size} -var os_type=${var.os_type} windows.pkr.hcl"
  }
 

}