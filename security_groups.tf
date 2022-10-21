module "dinusha_sg_bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = ">=4.13.0"

  name        = var.sg_dinusha_bastion
  description = "Security group for bastion host"
  vpc_id      = module.dinusha_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "dinusha_sg_app" {
  source  = "terraform-aws-modules/security-group/aws"
  version = ">=4.13.0"

  name        = var.sg_dinusha_app
  description = "Security group for App servers"
  vpc_id      = module.dinusha_vpc.vpc_id

  ingress_cidr_blocks = ["10.10.1.0/24"]
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
}