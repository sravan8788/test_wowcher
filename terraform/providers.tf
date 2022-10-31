provider "aws" {
  version = "~> 3.19"
  region  = var.region
}

terraform {
  backend "s3" {}
  required_version = ">= 0.13.5"
}