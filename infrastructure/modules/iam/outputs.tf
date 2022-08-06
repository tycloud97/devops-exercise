output "eks_master_role_name" {
  value = aws_iam_role.eks_master_role.name
}

output "eks_master_role_arn" {
  value = aws_iam_role.eks_master_role.arn
}


output "eks_nodegroup_role_name" {
  value = aws_iam_role.eks_nodegroup_role.name
}

output "eks_nodegroup_role_arn" {
  value = aws_iam_role.eks_nodegroup_role.arn
}
