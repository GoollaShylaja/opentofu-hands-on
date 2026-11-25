terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      demo = "opentofu-ec2-instance-creation-practice"
    }
  }
}

