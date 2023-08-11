terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}
provider "aws" {
  region = "eu-north-1"
}
resource "aws_instance" "ubuntu-web" {
  ami                     = "ami-0989fb15ce71ba39e"
  instance_type           = var.instance_type
  vpc_security_group_ids  = [ aws_security_group.amazon-web-server.id ]
  
  tags = local.common_tags
  
}


resource "aws_security_group" "amazon-web-server" {
    name        = "wb-sg"
    description = "Security group for web server"

    dynamic "ingress" {
      for_each = var.aws_security_group_ingress_ports
      content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
      }
    }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
