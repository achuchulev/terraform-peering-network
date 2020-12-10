variable "vpc_id" {
}

variable "tags" {
  type        = map(string)
  description = "VPC tag"

  default = {
    Name = ""
  }
}

variable "ssh_port" {
  default = 22
}

variable "ssh_cidr" {
  default = "0.0.0.0/0"
}

variable "icmp_cidr" {
  default = "0.0.0.0/0"
}
