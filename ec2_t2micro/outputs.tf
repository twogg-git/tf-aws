output "instance_id" {
  value = ["${aws_instance.ec2-ubu-t2m.*.id}"]
}

output "instance_info" {
  value = ["${aws_instance.ec2-ubu-t2m.*.tags}"]
}

output "instance_ips" {
  value = ["${aws_instance.ec2-ubu-t2m.*.public_ip}"]
}

output "instance_security_gropups" {
  value = ["${aws_instance.ec2-ubu-t2m.*.security_groups}"]
}

