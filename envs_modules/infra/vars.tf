variable "azone" {
  description = "Avaliability zone used by the scaling group"
  type        = string
}

variable "environment" {
  description = "Name used to namespace resources created by this module"
  type        = string
}

variable "max_size" {
  description = "Maximun number of replicas for the scaling group"
  type        = number
}

variable "min_size" {
  description = "Minimun number of replicas for the scaling group"
  type        = number
}
