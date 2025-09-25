resource "aws_instance" "public_nodes" {
  for_each                   = local.public_instances
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = module.network.public_subnets[each.value]
  vpc_security_group_ids      = [module.ssh_sg.sg_id]
  associate_public_ip_address = true

  user_data = file("${path.module}/user-data.sh")


  tags = {
    Name = each.key   # => "ankit1-public", etc.
  }
}


resource "aws_instance" "private_nodes" {
  for_each                   = local.private_instances
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = module.network.private_subnets[each.value]
  vpc_security_group_ids      = [module.ssh_sg.sg_id]
  associate_public_ip_address = false

  user_data = file("${path.module}/user-data.sh")


  tags = {
    Name = each.key   # => "ankit1-private", etc.
  }
}

# ECR repository for web app
resource "aws_ecr_repository" "my_web_app" {
  name                 = "my-web-app"
  image_tag_mutability = "MUTABLE"

  tags = {
    Environment = "dev"
    Project     = "EKS-WebApp"
  }
}

# Optional: lifecycle policy to clean old images
resource "aws_ecr_lifecycle_policy" "my_web_app_policy" {
  repository = aws_ecr_repository.my_web_app.name

  policy = <<POLICY
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 10 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
POLICY
}

