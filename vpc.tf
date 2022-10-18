module "dinusha_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.1"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

# resource "aws_internet_gateway" "dinusha_vpc_internet_gt" {
#   vpc_id = module.dinusha_vpc.vpc_id
#   tags = {
#     "Name" = "Dinusha VPC internet gateway"
#   }
# }

# resource "aws_route_table" "dinusha_vpc_rt" {
#   vpc_id = module.dinusha_vpc.vpc_id

#   route = {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.dinusha_vpc_internet_gt.id
#   }
# }

# resource "aws_route_table_association" "dinusha_vpc_subnet_association" {
#   subnet_id      = module.dinusha_vpc.public_subnets[0].id
#   route_table_id = aws_route_table.dinusha_vpc_rt.id
# }
