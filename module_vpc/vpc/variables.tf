variable "name" {
  description = "Prefix name for all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of Availability Zones to use, e.g. [\"ap-south-1a\", \"ap-south-1b\"]"
  type        = list(string)
}

