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
  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "Http ingress from App elb"
      source_security_group_id = "${module.dinusha_sg_elb.security_group_id}"
  }]
  ingress_rules = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  egress_rules  = ["all-all"]
}

module "dinusha_sg_elb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = ">=4.13.0"

  name        = var.sg_dinusha_elb
  description = "Security group for App ELB"
  vpc_id      = module.dinusha_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tpc"]
  egress_cidr_blocks  = ["10.10.3.0/24", "10.10.4.0/24"]
}