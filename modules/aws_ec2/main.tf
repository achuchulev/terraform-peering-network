resource "random_pet" "random_name" {
  length    = "4"
  separator = "-"
}

resource "aws_instance" "new_ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group_ids]
  key_name               = var.aws_key_pair_name

  tags {
    Name = random_pet.random_name.id
  }
}
