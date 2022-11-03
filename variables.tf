variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "dinusha-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags for VPC"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "ec2_bastion_name" {
  description = "Bastion host name"
  type        = string
  default     = "dinusha_ec2_bastion"
}

variable "ec2_app_1_name" {
  description = "App server name"
  type        = string
  default     = "dinusha_ec2_app_server_1"
}

variable "ec2_app_2_name" {
  description = "App server name"
  type        = string
  default     = "dinusha_ec2_app_server_2"
}

variable "sg_dinusha_bastion" {
  description = "Security group name for bastion host"
  type        = string
  default     = "dinusha_sg_bastion"
}

variable "sg_dinusha_app" {
  description = "Security group name for app servers"
  type        = string
  default     = "dinusha_sg_app"
}

variable "sg_dinusha_elb" {
  description = "Security group name for app ELB"
  type        = string
  default     = "dinusha_sg_elb"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""
}

variable "AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""
}

variable "dinusha_ssh_key" {
  description = "Dinusha SSH key name"
  type        = string
  default     = "dinusha_ssh_key"
}

variable "public_key_path" {
  description = "Public key path"
  type        = string
  default     = "keys/dinusha_public_key.pub"
}

variable "dinusha_app_elb" {
  description = "App ELB name"
  type        = string
  default     = "appelb"
}

variable "ec2_bastion_count" {
  description = "Bastion host count"
  type        = number
  default     = 1
}

variable "ec2_app_count" {
  description = "EC2 App server count"
  type        = number
  default     = 1
}