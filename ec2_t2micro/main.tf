terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region.id
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
	availability_zone = var.region.az
	key_name = var.key_pair
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data = data.template_file.user_data.rendered
	tags = var.tags
}

resource "aws_security_group" "sg" {
  name          = "ec2_sg"
  description   = "security group"
  tags          = var.tags
}

resource "aws_security_group_rule" "rule_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.cidr_block_all]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "rule_ingress" {
	count = length(var.inbound_ports)
  type              = "ingress"
  from_port         = var.inbound_ports[count.index]
  to_port           = var.inbound_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_block_all]
	security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "rule_ssh_ingress" {
	count = var.key_pair != "" ? 1 : 0
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_block_all]
	security_group_id = aws_security_group.sg.id
}

resource "aws_ebs_volume" "ebs" {
	count = var.ebs.status ? 1 : 0
  availability_zone = var.region.az
  size = var.ebs.size
  type = var.ebs.type
  tags = var.tags
}

resource "aws_volume_attachment" "ebs-attachment" {
	count = var.ebs.status ? 1 : 0
  device_name = "/dev/sdf"
  volume_id = aws_ebs_volume.ebs[0].id
  instance_id = aws_instance.ec2.id
}

data "template_file" "user_data" {
  template = file("${path.module}/data/init.sh")
}

