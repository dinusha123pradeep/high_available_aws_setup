module "dinusha_key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.dinusha_ssh_key
  public_key = file(var.public_key_path)
}