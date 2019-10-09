output "public_ip" {
  value       = aws_instance.ec2_t2m_webserver.public_ip
  description = "The public IP of the web server"
}