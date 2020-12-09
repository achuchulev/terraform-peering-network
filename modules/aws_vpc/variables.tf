variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {}

variable "aws_token" {}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "VPC cidr block"
}

variable "vpc_subnet_cidr_blocks" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "VPC subnet cidr blocks"
}

variable "vpc_tags" {
  type        = map(string)
  description = "VPC tag"

  default = {
    Name = ""
  }
}
