output "dinusha_vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.dinusha_vpc.public_subnets
}

output "dinusha_bastion_public_ips" {
  description = "Public IP address of Bastion node"
  value       = module.dinusha_ec2_bastion[0].public_ip
}

output "dinusha_elb_dns_name" {
  description = "App ELB dns name"
  value       = module.dinusha_elb_http.this_elb_dns_name
}
