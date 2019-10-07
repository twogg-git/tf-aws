provider "aws" {
  access_key = "${var.aws_keys.access}"
  secret_key = "${var.aws_keys.secret}"
  region = "${var.aws_region}"
}
resource "aws_db_instance" "mysql_t2micro" {
  identifier_prefix   = "test-mysql"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "test_mysql_db"
  username            = "admin"
  password            = "password"
}