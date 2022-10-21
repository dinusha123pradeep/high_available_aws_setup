module "dinusha_ec2_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">=4.1.4"

  count = 1

  name = var.ec2_bastion_name

  ami                    = data.aws_ami.dinusha_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.dinusha_sg_bastion.security_group_id]
  subnet_id              = module.dinusha_vpc.public_subnets[0]
  key_name               = module.dinusha_key_pair.key_pair_name
}

module "dinusha_ec2_app_1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">=4.1.4"

  count = 1

  name = var.ec2_app_1_name

  ami                    = data.aws_ami.dinusha_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.dinusha_sg_app.security_group_id]
  subnet_id              = module.dinusha_vpc.private_subnets[0]
  key_name               = module.dinusha_key_pair.key_pair_name

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true
}

module "dinusha_ec2_app_2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">=4.1.4"

  count = 1

  name = var.ec2_app_2_name

  ami                    = data.aws_ami.dinusha_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.dinusha_sg_app.security_group_id]
  subnet_id              = module.dinusha_vpc.private_subnets[1]
  key_name               = module.dinusha_key_pair.key_pair_name

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true
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