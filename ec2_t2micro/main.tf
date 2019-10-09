terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  access_key = var.aws_keys.access
  secret_key = var.aws_keys.secret
  region = "${var.aws_keys.region}"
}

resource "aws_ebs_volume" "ebs_volume_10gb" {
  availability_zone = "${var.aws_region_az}"
  size = 10
  type = "gp2"
  tags = {
    Name = "ebs_volume_10GB"
    "access" = "terraform-cli"
  }
}

resource "aws_security_group" "sg-io-tls" {
  name = "sg_tls_inbound_outbound"
  description = "Allow TLS inbound-outbound traffic"
  ingress {
    from_port = var.aws_tls_port
    to_port = var.aws_tls_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = var.aws_tls_port
    to_port = var.aws_tls_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_tls_inbound_outbound"
    "access" = "terraform-cli"
  }
}

resource "aws_instance" "ec2-ubu-t2m" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "${aws_security_group.sg-io-tls.id}"
  ]
  tags = {  
    Name = "ec2_ubuntu_t2micro"
    "access" = "terraform-cli."
  }
}

resource "aws_volume_attachment" "ebs-volume-attachment" {
  device_name = "/dev/sdf"
  volume_id = "${aws_ebs_volume.ebs_volume_10gb.id}"
  instance_id = "${aws_instance.ec2-ubu-t2m.id}"
}
