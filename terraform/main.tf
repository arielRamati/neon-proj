module "networking" {
    source   = "./modules/networking"
}

module "access_roles" {
    source = "./modules/access_roles"
    github_repository = "arielRamati/neon-proj"
}

module "eks" {
    source              = "./modules/eks"
    cluster_name        = "neon-app-cluster"
    vpc_id              = module.networking.vpc_id
    private_subnets     = module.networking.private_subnets
    deployer_role_arn   = module.access_roles.github_deployer_role_arn
}
