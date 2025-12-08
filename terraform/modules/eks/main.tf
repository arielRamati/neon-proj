module "eks" {
  source             = "terraform-aws-modules/eks/aws"
  version            = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.cluster_version
  subnet_ids         = var.private_subnets

  vpc_id             = var.vpc_id
  enable_irsa         = true
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups = {      
    default = {
        min_size     = 1
        max_size     = 3
        desired_size = 1

        instance_types = ["t3.small"]
        ami_type       = "AL2023_x86_64_STANDARD"
    }
  }

  addons = {
    coredns = {
        most_recent = true
    }

    eks-pod-identity-agent = {
        most_recent    = true
        before_compute = true
    }

    kube-proxy = {
        most_recent = true
    }

    vpc-cni = {
        most_recent    = true
        before_compute = true  # 🚀 Required for nodes to become Ready
    }
    }
}
