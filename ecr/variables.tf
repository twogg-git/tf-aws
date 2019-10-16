variable "aws_region" {
  description = "The AWS region in which all resources will be created"
  type        = string
}

variable "ecr_name" {
  description = "(Required) Name of the repository"
  type = string
}

variable "ecr_namespace" {
  description = "Repository namespace can be included with your repository name (e.g. namespace/repo-name)"
  default = ""
  type = string
}

variable "ecr_image_tag_mutability" {
  description = "[MUTABLE IMMUTABLE]. Select immutable when need to prevent image tags from being overwritten by subsequent image pushes using the same tag"
  default = "MUTABLE"  
  type = string
}