region = {
  id  = "us-east-1"
  az  = "us-east-1a"
}

tags = {
  "Name"  :"ec2_test"
  "Admin" :"engineer", 
  "Env"   :"development"
}

inbound_ports = [80]
