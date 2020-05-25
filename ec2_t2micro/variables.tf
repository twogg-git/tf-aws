variable "account" { 
	description =	"Region to use when creating the resources"
	type = map
}

variable "instance" {
	description = "EC2 instance info"
	type = map
}

variable "tags" {
	description = "List of tags to attach to resources"
  type = map
}

variable "inbound_ports" {
  description = "List of inbound ports to open"
	type = list
}

variable "ebs" {
	description = "True to create and attach EBS volume"
	type = map
	default = {
		status = false
		size = 0
		type = ""
	}	
}

data "aws_ami" "amazon-linux-2" {
 	most_recent = true
  owners = ["amazon"]
  filter {
    name   = "owner-alias"
  	values = ["amazon"]
  }

	filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
	}
}
