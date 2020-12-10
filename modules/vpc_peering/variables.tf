variable "enabled" {
  description = "Set to false to prevent the module from creating or accessing any resources"
  default     = "true"
}

variable "requester_vpc_id" {
  type        = string
  description = "Requester VPC ID"
}

variable "requester_peer_tags" {
  type        = map(string)
  description = "Requester peer tags"

  default = {
    Side = "A"
    Name = "VPCa-VPCb"
  }
}

variable "accepter_peer_tags" {
  type        = map(string)
  description = "Requester peer tags"

  default = {
    Side = "B"
    Name = "VPCa-VPCb"
  }
}

variable "accepter_vpc_id" {
  type        = string
  description = "Accepter VPC ID"
}

variable "region_b" {

}