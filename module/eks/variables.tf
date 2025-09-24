variable "cluster_name" {
  default = "ankit-eks"
}

variable "cluster_version" {
  default = "1.31"
}

variable "subnet_ids" { type = list(string) }

variable "security_group_ids" { type = list(string) }

# Nodegroups input
variable "nodegroups" {
  type = map(object({
    desired_size   = number
    min_size       = number
    max_size       = number
    instance_types = list(string)
  }))
  default = {
    default = {
      desired_size   = 3
      min_size       = 1
      max_size       = 5
      instance_types = ["t3.medium"]
    }
  }
}

# AWS Auth
variable "map_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}