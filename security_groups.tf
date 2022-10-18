module "dinusha_sg_bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = ">=4.13.0"

  name        = var.sg_dinusha_bastion
  description = "Security group for bastion host"
  vpc_id      = module.dinusha_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  // ingress_with_self   = ["all-all"]
  egress_rules = ["all-all"]
}