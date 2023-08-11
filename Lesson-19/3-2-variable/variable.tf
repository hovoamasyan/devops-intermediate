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
