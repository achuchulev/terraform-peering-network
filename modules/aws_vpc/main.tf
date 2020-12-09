# Create VPC resource
resource "aws_vpc" "new_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = var.vpc_tags
}

# Create subnets for VPC
resource "aws_subnet" "vpc_subnet" {
  count                   = length(var.vpc_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.new_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = var.vpc_subnet_cidr_blocks[count.index]

  tags = {
    Name = aws_vpc.new_vpc.tags.Name
  }
}

# Create Internet GW for VPC resource
resource "aws_internet_gateway" "vpc_internet_gw" {
  vpc_id = aws_vpc.new_vpc.id

  tags = {
    Name = "Internet Gateway for VPC ${aws_vpc.new_vpc.tags.Name}"
  }
}

# Create route for VPC internet access
resource "aws_route" "internet_access_vpc_route" {
  route_table_id         = aws_vpc.new_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_internet_gw.id
}

# Assosiate main route tables with subnets
resource "aws_route_table_association" "vpc_subnet_route_assoc" {
  count          = length(var.vpc_subnet_cidr_blocks)
  subnet_id      = aws_subnet.vpc_subnet[count.index].id
  route_table_id = aws_vpc.new_vpc.main_route_table_id
}

# Lookup for all VPC route tables

data "aws_route_tables" "route_tables" {
  vpc_id = aws_vpc.new_vpc.id
}
