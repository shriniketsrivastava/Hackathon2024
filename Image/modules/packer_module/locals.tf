locals {

  # Let's calculate the hash of all the contents of the packer directory.
  # We'll use this hash to determine if anything changed in the packer directory.
  packer_contents_hash        = md5(join(",", [for f in fileset("${path.module}/packer", "**") : filemd5("${path.module}/packer/${f}") if f != ".manifest.json"]))
  image_target_build_params   = "-var managed_image_name=${var.managed_image_name} -var image_publisher=${var.image_publisher}"
  resource_group_name          		= "Packer"
  tags                              = {

	Purpose     = "Hackathon2024"
  }
}