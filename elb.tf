module "dinusha_elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = var.dinusha_app_elb

  subnets         = [module.dinusha_vpc.private_subnets[0], module.dinusha_vpc.private_subnets[1]]
  security_groups = [module.dinusha_sg_app.security_group_id]
  internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 8080
      instance_protocol = "HTTP"
      lb_port           = 8080
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  // ELB attachments
  number_of_instances = 2
  instances           = [module.dinusha_ec2_app_1[0].id, module.dinusha_ec2_app_2[0].id]

  tags = {
    Owner       = "Dinusha"
    Environment = "dev"
  }
}