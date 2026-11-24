variable "region" {
  type = string
  description = "The region to deploy the resources"
  default = "ap-southeast-2"
}

variable "name_prefix" {
  type = string
  description = "a default name prefix to be added"
  default = "opentofu-aws-practice"
}