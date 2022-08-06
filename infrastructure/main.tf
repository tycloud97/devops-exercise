# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.14"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-ty"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "ap-southeast-1"

    # For State Locking
    dynamodb_table = "dev-ekscluster"
  }
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}


# Define Local Values in Terraform
locals {
  owners      = var.business_division
  environment = var.environment
  name        = "${var.business_division}-${var.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}

// Setup VPC network

module "vpc" {
  source           = "./modules/vpc"
  eks_cluster_name = local.eks_cluster_name
  common_tags      = local.common_tags
}

module "iam" {
  source = "./modules/iam"
  name   = local.name
}


module "eks" {
  source           = "./modules/eks"
  eks_cluster_name = local.eks_cluster_name
  name             = local.name
  public_subnets   = module.vpc.public_subnets
  private_subnets  = module.vpc.private_subnets

  eks_master_role_arn    = module.iam.eks_master_role_arn
  eks_nodegroup_role_arn = module.iam.eks_nodegroup_role_arn
  common_tags            = local.common_tags
}

# Datasource: 
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "k8s" {
  source                 = "./modules/k8s"
  eks_nodegroup_role_arn = module.iam.eks_nodegroup_role_arn
}


