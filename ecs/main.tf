terraform {
  required_version = ">= 0.12"
}

variable "aws_keys" { type = "map" }

provider "aws" {
  access_key = "${var.aws_keys.access}"
  secret_key = "${var.aws_keys.secret}"
  region = "${var.aws_keys.region}"
}

# ---------------------------------------------------------------------
# CREATE THE ECS CLUSTER
# ---------------------------------------------------------------------

module "ecs_cluster" {
  source = "git::git@github.com:gruntwork-io/module-ecs.git//modules/ecs-cluster?ref=v0.15.1"

  cluster_name = var.ecs_cluster_name

  cluster_min_size = 2
  cluster_max_size = 2

  cluster_instance_ami          = "${data.aws_ami.ubuntu.id}"
  # var.ecs_cluster_instance_ami
  cluster_instance_type         = "t2.micro"
  cluster_instance_keypair_name = var.ecs_cluster_instance_keypair_name
  cluster_instance_user_data    = data.template_file.user_data.rendered

  vpc_id                           = data.aws_vpc.default.id
  vpc_subnet_ids                   = data.aws_subnet.default.*.id
  allow_ssh                        = false
  allow_ssh_from_security_group_id = null
}

# ---------------------------------------------------------------------
# CREATE THE USER DATA SCRIPT THAT WILL RUN ON BOOT FOR EACH EC2 INSTANCE IN THE ECS CLUSTER
# This script will configure each instance so it registers in the right ECS cluster and authenticates to the proper
# Docker registry.
# ---------------------------------------------------------------------

data "template_file" "user_data" {
  template = file("${path.module}/user-data/user-data.sh")

  vars = {
    ecs_cluster_name = var.ecs_cluster_name
  }
}

# ---------------------------------------------------------------------
# CREATE AN ECS TASK DEFINITION
# You can run this ECS Task Definition in the ECS Cluster by using the run-ecs-task script in the ecs-deploy module.
# ---------------------------------------------------------------------

resource "aws_ecs_task_definition" "example" {
  family                = "${var.ecs_cluster_name}-example-task-definition"
  container_definitions = data.template_file.ecs_task_container_definitions.rendered
}

# ---------------------------------------------------------------------
# ECS TASK CONTAINER DEFINITIONS 
# Docker container(s) specific resources
# ---------------------------------------------------------------------

data "template_file" "ecs_task_container_definitions" {
  template = file("${path.module}/containers/container-definitions.json")

  vars = {
    container_name = "${var.ecs_cluster_name}-example-container"
    image          = var.docker_image
    version        = var.docker_image_version
    cpu            = 1024
    memory         = 512
    command        = "[${join(",", formatlist("\"%s\"", var.docker_image_command))}]"
  }
}

# ---------------------------------------------------------------------
# VPC AND SUBNETS
# VPC and private subnets setup for this docker container.
# ---------------------------------------------------------------------

data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "all" {}

data "aws_subnet" "default" {
  count             = min(length(data.aws_availability_zones.all.names), 3)
  availability_zone = element(data.aws_availability_zones.all.names, count.index)
  default_for_az    = true
}
