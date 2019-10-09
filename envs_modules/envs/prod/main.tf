terraform {
  required_version = ">= 0.12"
} 

variable "aws_keys" { type = "map" }

provider "aws" {
  access_key = "${var.aws_keys.access}"
  secret_key = "${var.aws_keys.secret}"
  region = "${var.aws_keys.region}"
}

module "prod_enviroment" {
	source = "../../infra"
	min_size = 3
	max_size = 5
	environment = "prod"
  azone = "${var.aws_keys.azone}"
}