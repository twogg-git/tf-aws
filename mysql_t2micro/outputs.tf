output "address" {
  value       = "${aws_db_instance.mysql_t2micro.address}"
  description = "Connect to the database at this endpoint"
}
output "port" {
  value       = "${aws_db_instance.mysql_t2micro.port}"
  description = "The port the database is listening on"
}