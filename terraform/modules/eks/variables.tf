variable "cluster_name" {
    type = string
}

variable "cluster_version" {
    type    = string
    default = "1.30"
}

variable "vpc_id" {
    type = string
}

variable "private_subnets" {
    type = list(string)
}

variable "deployer_role_arn" {
    type = string
}
