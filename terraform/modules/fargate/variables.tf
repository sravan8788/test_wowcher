variable "tags" {
  description = "the tags"
  type = map(string)
}

variable "aws_account_id" {
  description = "the id of the aws account"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cpu" {
  description = "fargate cpu"
  default     = "512"
}

variable "memory" {
  description = "fargate memory"
  default     = "1024"
}

variable "docker_image_tag" {
  description = "tag for the docker image to be used"
  default     = "latest"
}

variable "task-env-vars" {
  type        = list(map(string))
  description = "List of enviornment variables to be run inside the the docker containers"
  default     = []
}

variable "ingress_sg_ids" {
  type        = list(string)
  description = "List of sg groups"
  default     = []
}

variable "task-env-secrets" {
  type        = list(map(string))
  description = "List of secrets to retrieve from Secrets Manager and pass to ECS as environment variables"
  default     = []
}

variable "name" {
  description = "the name of the fargate task"
  type        = string
}

variable "domain" {
  description = "the name of the fargate task"
  type        = string
}

variable "route53_zone_id" {
  description = "route53 zone id"
  type        = string
}

variable "docker_image" {
  description = "the docker image name"
  type        = string
  default     = "grafana/grafana"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}



variable "cert_arn" {
  description = "arn of cert"
  type        = string
}

variable "private_subnet_ids" {
  description = "private subnet id's"
  type        = list(string)
  default     = null
}

variable "alb_internal" {
  description = "alb is private or public facing"
  type        = bool
  default     = true
}

variable "public_subnet_ids" {
  description = "public subnet id's"
  type        = list(string)
  default     = null
}

variable "desired_count" {
  description = "desired count of task"
  default     = 1
}

variable "listener_port" {
  description = "listner port that alb group and listener mapping to"
  type        = number
  default     = 3000
}

variable "health_check_return_path" {
  description = "health check api path to look for"
  default     = "/"
  type        = string
}

variable "health_check_return_code" {
  description = "health check api expected return code if successful"
  default     = 200
  type        = number
}

variable "health_port" {
  description = "target group health check port to check for http status"
  default     = 0
  type        = number
}

variable "scale_target_min_capacity" {
  description = "manimum number of instances in a cluster"
  default = 1
  type = number

}

variable "scale_target_max_capacity" {
  description = "maximum number of instances in a cluster"
  type        = number
  default     = 5
}

variable "max_cpu_threshold" {
  description = "Threshold for max CPU usage"
  default     = "85"
  type        = string
}

variable "min_cpu_threshold" {
  description = "Threshold for min CPU usage"
  default     = "10"
  type        = string
}

variable "max_cpu_evaluation_period" {
  description = "The number of periods over which data is compared to the specified threshold for max cpu metric alarm"
  default     = "3"
  type        = string
}

variable "min_cpu_evaluation_period" {
  description = "The number of periods over which data is compared to the specified threshold for min cpu metric alarm"
  default     = "3"
  type        = string
}

variable "max_cpu_period" {
  description = "The period in seconds over which the specified statistic is applied for max cpu metric alarm"
  default     = "60"
  type        = string
}

variable "min_cpu_period" {
  description = "The period in seconds over which the specified statistic is applied for min cpu metric alarm"
  default     = "60"
  type        = string
}