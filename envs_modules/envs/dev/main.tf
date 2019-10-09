terraform {
  required_version = ">= 0.12"
} 

variable "aws_keys" { type = "map" }

provider "aws" {
  access_key = "${var.aws_keys.access}"
  secret_key = "${var.aws_keys.secret}"
  region = "${var.aws_keys.region}"
}

module "dev_enviroment" {
	source = "../../infra"
	min_size = 1
	max_size = 2
	environment = "dev"
  azone = "${var.aws_keys.azone}"
}