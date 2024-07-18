locals {

  # Let's calculate the hash of all the contents of the packer directory.
  # We'll use this hash to determine if anything changed in the packer directory.
  packer_contents_hash        = md5(join(",", [for f in fileset("${path.module}/packer", "**") : filemd5("${path.module}/packer/${f}") if f != ".manifest.json"]))

}