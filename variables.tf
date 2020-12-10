variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_token" {}

variable "region_a" {
  default = "us-east-1"
}

variable "region_b" {
  default = "us-west-1"
}

variable "ami_a" {
  description = "Official Ubuntu 20.04 ami in us-east-1"
  default     = "ami-0885b1f6bd170450c"
}

variable "ami_b" {
  description = "Official Ubuntu 20.04 ami in us-west-1"
  default     = "ami-00831fc7c1e3ddc60"
}

variable "aws_key_pair_name_vpc_a" {
  default = "atanas_key_pair"
}

variable "aws_key_pair_name_vpc_b" {
  default = "atanas_key_pair"
}

variable "activate_peering" {
  description = "Set to false to prevent the module from creating or accessing any resources"
  default     = "true"
}

variable "requester_vpc_name" {
  description = "Set a VPC name"
  default     = "A"
}

variable "accepter_vpc_name" {
  description = "Set a VPC name"
  default     = "B"
}

variable "requester_vpc_cidr_block" {
  description = "Define requester VPC cidr blocks"
  default     = "10.100.0.0/16"
}

variable "accepter_vpc_cidr_block" {
  description = "Define accepter VPC cidr block"
  default     = "10.200.0.0/16"
}

variable "requester_vpc_subnet_cidr_blocks" {
  type        = list(string)
  description = "Define VPC subnet cidr blocks"
  default     = ["10.100.0.0/24", "10.100.1.0/24"]
}

variable "accepter_vpc_subnet_cidr_blocks" {
  type        = list(string)
  description = "Define VPC subnet cidr blocks"
  default     = ["10.200.0.0/24", "10.200.1.0/24"]
}
