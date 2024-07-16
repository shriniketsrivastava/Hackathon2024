data "local_file" "image_version" {
  filename = "${path.module}/packer/.image_version"
  depends_on = [ terraform_data.packer_template ]
}
