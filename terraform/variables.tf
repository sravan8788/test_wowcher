variable "tags" {
}

variable "global" {
  description = "a map of key/value tags to add to aws resources"
  default     = {}
}

variable "region" {
  description = "aws region"
}

variable "vpc_name" {
  description = "VPC name"
}

variable "cert_name" {
  description = "acm cert name"
}

variable "domain" {
  description = "route53 domain"
}

variable "app_port" {
  description = "application port"
}

variable "private_subnet_cidrs" {
  description = "private subnet cidr's"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "public subnet cidr's"
  type        = list(string)
}

variable "delimiter" {
  description = "The delimiter to use in the name, between variables"
  default     = "-"
}
