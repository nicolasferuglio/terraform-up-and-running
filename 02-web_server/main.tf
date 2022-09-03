provider "aws" {
  region = "us-east-2"
}

resource "aws_launch_configuration" "first_cluster" {
  image_id                      = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  security_groups = [aws_security_group.allow_http.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.port} &
              EOF

}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"


  ingress {
    description      = "Http from VPC"
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

variable "port" {
  type        = number
  description = "Port fo ingress"
  default     = 8080
}

output "public_ip" {
    value = aws_instance.first_instance.public_ip
    description = "The public IP to send requests"
  
}