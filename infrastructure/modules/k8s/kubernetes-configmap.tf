# Get AWS Account ID
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}


# Sample Role Format: arn:aws:iam::180789647333:role/hr-dev-eks-nodegroup-role
# Locals Block
locals {
  configmap_roles = [
    {
      rolearn  = "${var.eks_nodegroup_role_arn}"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    },
  ]
}
# Resource: Kubernetes Config Map
# resource "kubernetes_config_map_v1" "aws_auth" {
#   # depends_on = [
#   #   aws_eks_cluster.eks_cluster,
#   # ]
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }
#   data = {
#     mapRoles = yamlencode(local.configmap_roles)
#   }
# }

