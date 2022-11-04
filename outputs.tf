##########################
# Output - AWS load balancer DNS name 
##########################
output "alb-dns-name" {
  value = aws_elb.alb.dns_name
}
