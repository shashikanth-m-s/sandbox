terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
  }

  backend "s3" {
    bucket = "sandbox-tfstate-274266060383"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# Connect to the newly created EKS cluster
provider "kubernetes" {
  host                   = aws_eks_cluster.sandbox_eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.sandbox_eks.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.sandbox_eks.name]
    command     = "aws"
  }
}