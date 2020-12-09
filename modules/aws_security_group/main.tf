# Create security group for VPC that allows ssh and icmp echo request/reply inbound traffic 
resource "aws_security_group" "vpc_ssh_icmp_echo_sg" {
  name        = "ssh_icmp_echo_enabled_sg"
  description = "Allow traffic needed for ssh and icmp echo request/reply"
  vpc_id      = var.vpc_id

  // Custom ICMP Rule - IPv4 Echo Reply
  ingress {
    from_port   = "0"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = [var.icmp_cidr]
  }

  // Custom ICMP Rule - IPv4 Echo Request
  ingress {
    from_port   = "8"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = [var.icmp_cidr]
  }

  // ssh
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  // all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tags.Name
  }
}
