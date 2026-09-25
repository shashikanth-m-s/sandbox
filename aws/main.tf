# Standard VPC
resource "aws_vpc" "sandbox_vpc" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "sandbox-aws-vpc"
    Environment = "Dev"
  }
}

# Public Subnet in us-east-1a
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.sandbox_vpc.id
  cidr_block              = "10.30.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sandbox-public-subnet"
  }
}

# Internet Gateway for internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sandbox_vpc.id

  tags = {
    Name = "sandbox-igw"
  }
}

# Route table routing external traffic to IGW
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

output "vpc_id" {
  value = aws_vpc.sandbox_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}