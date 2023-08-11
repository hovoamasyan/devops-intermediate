terraform {
  required_providers {
    aws       = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}
provider "aws" {
  region = "eu-north-1"
}
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = {
    Name     = "terraform-vpc"
  }
}
resource "aws_subnet" "terraform-vpc" {
  vpc_id            = data.aws_vpcs.terraform-vpc.ids[1]
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block        = "10.0.0.0/24"
  depends_on        = [ aws_vpc.terraform-vpc ]
  tags              = {
    Name            = "subnet1"
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_instance" "ubuntu-web" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [ aws_security_group.ubuntu-web-server.id ]
  tags                    = local.common_tags
  depends_on              = [ aws_instance.ubuntu-db, aws_instance.ubuntu-backend ]
  subnet_id               = aws_subnet.terraform-vpc.id
}
resource "aws_instance" "ubuntu-backend" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [ aws_security_group.ubuntu-web-server.id ]
  tags                    = local.common_tags
  depends_on              = [ aws_instance.ubuntu-db ]
  subnet_id               = aws_subnet.terraform-vpc.id
}
resource "aws_instance" "ubuntu-db" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [ aws_security_group.ubuntu-web-server.id ]
  tags                    = local.common_tags
  depends_on              = [ aws_security_group.ubuntu-web-server ]
  subnet_id               = aws_subnet.terraform-vpc.id
}
resource "aws_security_group" "ubuntu-web-server" {
    name        = "wb-sg"
    description = "Security group for web server"
    vpc_id      = data.aws_vpcs.terraform-vpc.ids[1]

    dynamic "ingress" {
      for_each      = var.aws_security_group_ingress_ports
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
data "aws_vpcs" "terraform-vpc" {
}
data "aws_availability_zones" "working" {
}
data "aws_region" "current" {
}


