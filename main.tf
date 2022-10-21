provider "aws" {
  region = "us-east-1"
}

locals {
  user_data = <<-EOT
  #!/bin/bash
  yum update -y
  yum install -y httpd
  systemctl start httpd.service
  systemctl enable httpd.service
  echo "Hello World from $(hostname -f)" > /var/www/html/index.html
  EOT
}