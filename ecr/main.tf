# variable "aws_keys" { type = map }

# provider "aws" {
#   version = "~> 2.6"
#   # access_key = var.aws_keys.access
#   # secret_key = var.aws_keys.secret
#   # region = var.aws_region
# }

provider "aws" {
  version = "~> 2.6"
  region                  = "eu-central-1"
  shared_credentials_file = "/home/ccruz/.aws/creds"
  profile                 = "default"
}

resource "aws_ecr_repository" "ecr_repository" {
  name = var.ecr_name
  image_tag_mutability = var.ecr_image_tag_mutability
}