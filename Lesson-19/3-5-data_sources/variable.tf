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
  default = [ "80","443","8008","1541","22","9090" ]
  
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
  value = aws_security_group.amazon-web-server.id
  
}
output "aws_security_group_vpc_id" {
  value = aws_security_group.amazon-web-server.vpc_id
  
}
