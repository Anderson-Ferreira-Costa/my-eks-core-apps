
data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "default" {
  name = local.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = local.cluster_name
}

data "aws_subnets" "subnets" {
  filter {
    name   = "tag:Name"
    values = ["*cni-pods*"]
  }
}

# data "aws_subnet" "subnet_1" {
#   id = element(data.aws_subnets.subnets.ids, 0)
# }
# data "aws_subnet" "subnet_2" {
#   id = element(data.aws_subnets.subnets.ids, 1)
# }
# data "aws_subnet" "subnet_3" {
#   id = element(data.aws_subnets.subnets.ids, 2)
# }

data "aws_security_group" "sg_node" {
  filter {
    name   = "tag:Name"
    values = ["*worker_sg*"]
  }
}

locals {
  region = var.region
  cluster_name = var.cluster_name
  oidc         = substr(data.aws_eks_cluster.default.identity[0].oidc[0].issuer, 8, length(data.aws_eks_cluster.default.identity[0].oidc[0].issuer))
  account_id   = data.aws_caller_identity.current.account_id
  vpc_id       = data.aws_eks_cluster.default.vpc_config[0].vpc_id
  # subnet_1     = data.aws_subnet.subnet_1
  # subnet_2     = data.aws_subnet.subnet_2
  # subnet_3     = data.aws_subnet.subnet_3
  sg_node      = data.aws_security_group.sg_node
}

