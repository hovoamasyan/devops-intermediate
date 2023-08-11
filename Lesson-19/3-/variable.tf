variable "instance_type" {
    default = "t3.micro"
  
}
variable "Owner" {
    default =  "Hovhannes"
  
}
locals {
  common_tags = {
    Owner = "Hovhannes"
  }
}
variable "aws_security_group_ingress_ports" {
  type = list(any)
  default = [ "80","22", ]
  
}
output "aws_instance_id" {
  value = aws_instance.ubuntu-web.id

}
output "aws_instance_arn" {
  value = aws_instance.ubuntu-web.arn

}
output "aws_instance_public_ip" {
  value = aws_instance.ubuntu-web.public_ip

}
output "aws_security_group_id" {
  value = aws_security_group.ubuntu-web-server.name
  
}
output "aws_security_group_vpc_id" {
  value = aws_security_group.ubuntu-web-server.vpc_id
  
}
output "aws_availability_zones_working" {
  value = data.aws_availability_zones.working.names
  
}
output "aws_region_current" {
  value = data.aws_region.current.id
  
}
output "aws_region_current_description" {
  value = data.aws_region.current.description
}
output "vpc_id" {
  value = data.aws_vpcs.terraform-vpc.ids

}
output "aws_subnet_vpc_id" {
  value = aws_subnet.terraform-vpc.id
}