account = {
  region = "us-east-1"
  az = "us-east-1a"
}

tags = {
	"Name":"ec2_t2micro"
	"Admin":"dev-web", 
  "Environment":"development"
}

instance = {
  type = "t2.micro"
  key_pair = "dev-web"
}

ebs = {
  status = true
	size = 10
	type = "gp2"	
}

inbound_ports = [22, 80]
