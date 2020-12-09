# Outputs security group id
output "sg_id" {
  value = aws_security_group.vpc_ssh_icmp_echo_sg.id
}
