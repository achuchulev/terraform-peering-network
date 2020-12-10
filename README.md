# Example of terraform code for 2 VPC in 2 Region, 2 EC2 instance in each region that reach each other over private IP addresses

## Prerequisites

- git
- terraform (>=0.12)
- AWS subscription
- ssh key pair in each AWS region

## How to use

- Clone the repo locally

```
$ git clone https://github.com/achuchulev/terraform-peering-network.git && cd terraform-peering-network
```

- Create `terraform.tfvars` file

```
aws_access_key = "your_aws_access_key"
aws_secret_key = "your_aws_secret_key"
aws_token      = "aws_session_token"
```


### Initialize terraform and plan/apply

```
$ terraform init
$ terraform plan
$ terraform apply
```

- `Terraform apply` will create:
  - VPC in each AWS region (default: us-east-1 and us-west-1)
  - ec2 instance in each VPC
  - security group in each VPC to allow ssh and icmp traffic
  - peering between the 2 VPCs
  
#### Inputs

| Name  |	Description |	Type |  Default |	Required
| ----- | ----------- | ---- |  ------- | --------
| aws_access_key | AWS access key Region A | string | - | yes
| aws_secret_key | AWS access key Region B | string | - | yes
| aws_token | AWS session token | string | - | yes
| region_a | AWS region A | string | "us-east-1" | no
| region_a | AWS region B | string | "us-west-1" | no
| ami_a | Ubuntu Focal AWS AMI in AWS region `us-east-1` | string | "ami-0885b1f6bd170450c" | no
| ami_b | Ubuntu Focal AWS AMI in AWS region `us-west-1` | string | "ami-00831fc7c1e3ddc60" | no
| aws_key_pair_name_vpc_a | AWS key pair in AWS region `us-east-1`  | string | "atanas_key_pair" | no
| aws_key_pair_name_vpc_b | AWS key pair in AWS region `us-west-1`  | string | "atanas_key_pair" | no
| instance_type_frontend | Nomad frontend EC2 instance type | string | "t2.micro" | no
| activate_peering | Switch to enable/disable VPC peering | bool | "true" | no
| requester_vpc_name | Sets the name of VPC A as for tag | string | "A" | no
| accepter_vpc_name | Sets the name of VPC B as for tag | string | "B" | no
| requester_vpc_cidr_block | AWS VPC A cidr | string | "10.100.0.0/16" | no
| accepter_vpc_cidr_block | AWS VPC B cidr | string | "10.200.0.0/16" | no
| requester_vpc_subnet_cidr_blocks | VPC A subnets | list(string) | ["10.100.0.0/24", "10.100.1.0/24"] | no
| accepter_vpc_subnet_cidr_blocks | VPC B subnets | list(string) | ["10.200.0.0/24", "10.200.1.0/24"] | no

#### Outputs

| Name  |	Description 
| ----- | ----------- 
| ec2_vpc_a_private_ip | Private IP of ec2 instance in AWS region A
| ec2_vpc_a_public_ip | Public IP of ec2 instance in AWS region A
| ec2_vpc_b_private_ip | Private IP of ec2 instance in AWS region B
| ec2_vpc_b_public_ip | Public IP of ec2 instance in AWS region B
| peering_connection_id  | VPC perring connection id
| peering_status  | VPC perring status
| vpc_a_id | id of the VPC in AWS region A
| vpc_b_id | id of the VPC in AWS region B

## Test connectivity between both instances on private network

- ssh to node in region A `ssh ubuntu@ec2_vpc_a_public_ip`
- ping instance in regioon B `ping ec2_vpc_b_private_ip`

