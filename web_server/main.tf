terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  access_key = "${var.aws_keys.access}"
  secret_key = "${var.aws_keys.secret}"
  region = "${var.aws_keys.region}"
}

resource "aws_instance" "ec2_t2m_webserver" {
    
  ami = "${data.aws_ami.ubuntu.id}" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_in_all.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "Up and running..." > index.html
    nohup busybox httpd -f -p "${var.server_port}" &
    EOF

  tags = {
    Name = "ec2_t2m_webserver"
  }
}

resource "aws_security_group" "sg_in_all" {
  name = "sg_in_all"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}