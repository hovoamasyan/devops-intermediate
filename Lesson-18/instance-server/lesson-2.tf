terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}
resource "aws_instance" "amazon-web" {
  ami           = "ami-040d60c831d02d41c"
  instance_type = "t3.micro"
  key_name = "DevOps"
  count = 2

  tags = {
    Name = "amazon"
  }
}
resource "aws_instance" "ubuntu-web" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  key_name = "DevOps"

  tags = {
    Name = "ubuntu"
  }
}