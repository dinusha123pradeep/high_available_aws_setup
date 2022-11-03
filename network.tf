##########################
# AWS VPC
##########################
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = "dinusha_ha_vpc"
  }
}

##########################
# AWS SUBNET - public subnets
##########################
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_public_subnets[count.index]
  availability_zone       = var.vpc_azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "dinusha_ha_public_subnet_${count.index + 1}"
  }
}

##########################
# AWS SUBNET - private subnet
##########################
resource "aws_subnet" "private_app" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_private_subnets[count.index]
  availability_zone = var.vpc_azs[count.index]

  tags = {
    "Name" = "dinusha_ha_private_app_subnet_${count.index + 1}"
  }
}

##########################
# AWS Internet gateway
##########################
resource "aws_internet_gateway" "vpc_ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "dinusha_ha_internet_gateway"
  }
}

##########################
# AWS NAT gateway
##########################
resource "aws_nat_gateway" "vpc_nat" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.public[0].id

  tags = {
    "Name" = "dinusha_ha_nat_gateway"
  }
}

##########################
# AWS Route table - public
##########################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_ig.id
  }

  tags = {
    "Name" = "dinusha_ha_public_route_table"
  }
}

##########################
# AWS Route table association - public
##########################
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

##########################
# AWS Route table - private
##########################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = aws_nat_gateway.vpc_nat.id
  }

  tags = {
    "Name" = "dinusha_ha_private_route_table"
  }
}

##########################
# AWS Route table association - private
##########################
resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = element(aws_subnet.private_app[*].id, count.index)
  route_table_id = aws_route_table.private.id
}