region = {
  id  = "us-east-1"
  az  = "us-east-1a"
}

tags = {
	"Name"  :"ec2_test"
	"Admin" :"engineer", 
  "Env"   :"development"
}

ebs = {
  status  = true
	size    = 10
	type    = "gp2"	
}

inbound_ports = [80]
