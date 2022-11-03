output "dinusha_vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = aws_subnet.public[*].id
}

output "alb-dns-name" {
  value = aws_elb.alb.dns_name
}
