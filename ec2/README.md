## EC2 Provisioning example

To test use Terraform common commands:
```sh 
terraform init
terraform apply
```

Output example:
```sh
ec2_dns = [
  "ec2-12-345-67-89.compute-1.amazonaws.com",
]
ec2_id = [
  "i-12abc345efg678",
]
ec2_ip = [
  "12.345.67.89",
]
```

To test GO web page on port 80, use your ec2_dns URL, example http://ec2-12-345-67-89.compute-1.amazonaws.com
