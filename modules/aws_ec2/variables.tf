variable "ami" {
  description = "AWS AMI id"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "AWS subnet id"
}

variable "aws_key_pair_name" {
  description = "An existing aws key pair name for the instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "AWS VPC security group ids"
}
