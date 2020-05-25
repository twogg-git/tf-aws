variable "region" { 
  description =	"Region and AZ to use when creating the resources"
  type = map 
  default = {
		id  = "..."
		az  = "..."
 	}
}

variable "instance_type" {
	description = "EC2 type"
	type = string
	default = "t2.micro"
}

variable "key_pair" {
	description = "EC2 key pair name"
	type = string
	default = ""
}

variable "tags" {
	description = "List of tags to attach to resources"
	type = map
}

variable "inbound_ports" {
	description = "List of inbound ports to open"
	type = list
}

variable "cidr_block_all" {
	description = "All cidr block"
	type = string
	default = "0.0.0.0/0"
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
	owners 			= ["amazon"]
	filter {
		name   	= "owner-alias"
		values 	= ["amazon"]
	}
	filter {
		name   	= "name"
		values 	= ["amzn2-ami-hvm*"]
	}
}
