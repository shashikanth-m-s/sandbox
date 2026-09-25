# ============================================================
# 1. NETWORKING (EKS Requires at least 2 AZs)
# ============================================================
resource "aws_vpc" "sandbox_vpc" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "sandbox-aws-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sandbox_vpc.id

  tags = {
    Name = "sandbox-igw"
  }
}

# Subnet 1: us-east-1a (Imported earlier)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = "10.30.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "sandbox-public-subnet-1a"
    "kubernetes.io/role/elb" = "1"
  }
}

# Subnet 2: us-east-1b (Required for EKS)
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = "10.30.2.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "sandbox-public-subnet-1b"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.sandbox_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "sandbox-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# ============================================================
# 2. IAM ROLES FOR EKS CLUSTER & WORKER NODES
# ============================================================
# Cluster Control Plane Role
resource "aws_iam_role" "eks_cluster_role" {
  name = "sandbox-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Worker Node Role
resource "aws_iam_role" "eks_node_role" {
  name = "sandbox-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

# ============================================================
# 3. EKS CLUSTER & MANAGED NODE GROUP
# ============================================================
resource "aws_eks_cluster" "sandbox_eks" {
  name     = "sandbox-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.31" # Standard support version compliant with sandbox limits

  vpc_config {
    subnet_ids              = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_2.id]
    endpoint_public_access  = true
    endpoint_private_access = false
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}

resource "aws_eks_node_group" "sandbox_nodes" {
  cluster_name    = aws_eks_cluster.sandbox_eks.name
  node_group_name = "sandbox-standard-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_2.id]

  # Allowed instance types: t3.small fits sandbox limits and 9-node cap
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly
  ]
}

# ============================================================
# 4. KUBERNETES WORKLOAD: STATIC WEBSITE POD & SERVICE
# ============================================================
resource "kubernetes_config_map" "html_content" {
  metadata {
    name = "web-html"
  }

  data = {
    "index.html" = <<-EOT
      <!DOCTYPE html>
      <html>
      <body style="font-family: Arial, sans-serif; text-align: center; padding-top: 50px;">
        <h1>Welcome to Amazon EKS!</h1>
        <p>Running inside a Kubernetes Pod on AWS Cloud Sandbox.</p>
        <p>Deployed via Terraform and Azure DevOps Pipelines.</p>
      </body>
      </html>
    EOT
  }

  depends_on = [aws_eks_node_group.sandbox_nodes]
}

resource "kubernetes_deployment" "nginx_web" {
  metadata {
    name = "nginx-static-web"
    labels = {
      app = "static-web"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "static-web"
      }
    }

    template {
      metadata {
        labels = {
          app = "static-web"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:alpine"

          port {
            container_port = 80
          }

          volume_mount {
            name       = "html-volume"
            mount_path = "/usr/share/nginx/html"
          }
        }

        volume {
          name = "html-volume"
          config_map {
            name = kubernetes_config_map.html_content.metadata[0].name
          }
        }
      }
    }
  }

  depends_on = [aws_eks_node_group.sandbox_nodes]
}

# LoadBalancer service creates an AWS Elastic Load Balancer (ELB)
resource "kubernetes_service" "nginx_service" {
  metadata {
    name = "static-web-lb"
  }

  spec {
    selector = {
      app = kubernetes_deployment.nginx_web.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }

  depends_on = [kubernetes_deployment.nginx_web]
}

# ============================================================
# 5. OUTPUTS
# ============================================================
output "load_balancer_hostname" {
  description = "Public Load Balancer URL for the static website"
  value       = kubernetes_service.nginx_service.status[0].load_balancer[0].ingress[0].hostname
}