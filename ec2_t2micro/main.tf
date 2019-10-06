provider "aws" {
  access_key = "${var.aws_keys.access}"
  secret_key = "${var.aws_keys.secret}"
  region = "${var.aws_region}"
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

resource "aws_security_group" "sg-io-443" {
  name = "sg_443_inbound_outbound"
  description = "Allow TLS inbound-outbound traffic"
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_443_inbound_outbound"
    "access" = "terraform-cli"
  }
}

resource "aws_instance" "ec2-ubu-t2m" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "${aws_security_group.sg-io-443.id}"
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
