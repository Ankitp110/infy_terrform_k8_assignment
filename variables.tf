# Key pair (already created)
variable "key_name" {
  default = "ankit-key"
}

variable "ami_id" {
  default = "ami-01b6d88af12965bb6"
}

# List of EC2 instance names
#locals {
#  instance_names = ["ankit1","ankit2","ankit3","ankit4","ankit5"]
#}

locals {
  # Keys are the *actual names* you want in the tags
  public_instances = {
    "ankit1-public" = 0
    "ankit2-public" = 1
  }

  private_instances = {
    "ankit1-private" = 0
    "ankit2-private" = 1
  }
}



