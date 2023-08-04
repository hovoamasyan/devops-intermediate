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
resource "aws_instance" "amazon-web" {
  ami           = "ami-040d60c831d02d41c"
  instance_type = "t3.micro"
  key_name = "DevOps"
  count = 1
  #user_data = file("user_data.sh")
  user_data = templatefile("user_data.tpl", {
    first_name = "Hovhannes",
    last_name  = "Amasyan",
    names      = ["Artur","Areg","Sergey","Movses","Sargis","Levon","Shant","Taron","Hovhannes"]
  })

  tags = {
    Name  = "amazon"
    Owner = "Amasyan"
  }

  vpc_security_group_ids = [ aws_security_group.amazon-web-server.id ]
}

resource "aws_security_group" "amazon-web-server" {
    name = "wb-sg"
    description = "my first sg in terraform"

    ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
