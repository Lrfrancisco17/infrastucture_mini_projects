terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# --- Networking ---

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "rhel10-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rhel10-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "rhel10-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rhel10-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# --- Security group ---

resource "aws_security_group" "rhel10_sg" {
  name        = "rhel10-sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rhel10-sg"
  }
}

# --- RHEL AMI lookup (adjust filters/owners to match your account/region) ---

data "aws_ami" "rhel10" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-10*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Replace with the correct Red Hat owner ID for your region/account if needed
  owners = ["309956199498"] # Example: Red Hat in many regions
}

# --- EC2 instance ---

resource "aws_instance" "rhel10" {
  ami                    = data.aws_ami.rhel10.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.rhel10_sg.id]

  # Explicitly ensure public IP (plus subnet map_public_ip_on_launch)
  associate_public_ip_address = true
  key_name                    = "my-keypair"

  tags = {
    Name = "rhel10-ec2"
  }
}

output "rhel10_public_ip" {
  value       = aws_instance.rhel10.public_ip
  description = "Public IP of the RHEL10 EC2 instance"
}

