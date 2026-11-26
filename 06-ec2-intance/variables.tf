variable "region" {
  type        = string
  description = "The region to deploy the resources"
  default     = "ap-southeast-2"
}

variable "name_prefix" {
  type        = string
  description = "a default name prefix to be added"
  default     = "opentofu-aws-practice"
}

variable "instance_minimum_memory" {
  type    = number
  default = 1
  description = "Minum meory in GB for the instance"
}