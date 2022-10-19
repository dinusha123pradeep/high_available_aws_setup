module "dinusha_ec2_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">=4.1.4"

  count = 1

  name = var.ec2_bastion_name

  ami                    = data.aws_ami.dinusha_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.dinusha_sg_bastion.security_group_id]
  subnet_id              = module.dinusha_vpc.public_subnets[0]
}

data "aws_ami" "dinusha_ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_eip" "dinusha_bastion_eip" {
  instance = module.dinusha_ec2_bastion[0].id
  vpc      = true
}