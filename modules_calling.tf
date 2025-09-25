# Module call to create a security group
module "ssh_sg" {
  source      = "./module_sg/security_group"
  sg_name     = "ssh_sg"
  description = "Allow SSH inbound and HTTP inbound"
   vpc_id      = module.network.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "eks_sg" {
  source      = "./module_sg/security_group"
  sg_name     = "eks-cluster-sg"
  description = "EKS cluster control plane SG"
  vpc_id      = module.network.vpc_id

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]   # allow control plane access
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


module "network" {
  source   = "./module_vpc/vpc"
  name     = "ankit-demo"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["ap-south-1a", "ap-south-1b"]
}


module "eks" {
  source = "./module/eks"

  cluster_name       = "ankit-eks-cluster"
  cluster_version    = "1.31"
  subnet_ids         = module.network.private_subnets
  security_group_ids = [module.eks_sg.sg_id]

  nodegroups = {
    default = {
      desired_size   = 3
      min_size       = 1
      max_size       = 5
      instance_types = ["t3.medium"]
    },
    extra = {
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      instance_types = ["t3.small"]
    }
  }

  map_users = [
    {
      userarn  = "arn:aws:iam::637423217175:user/ankit_test"
      username = "ankit_test"
      groups   = ["system:masters"]
    }
  ]

  map_roles = [
    {
      rolearn  = "arn:aws:iam::637423217175:role/eks-admin-role"
      username = "eks-admin"
      groups   = ["system:masters"]
    }
  ]
}

