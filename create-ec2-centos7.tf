# Configure AWS Provider
provider "aws" {
  region = "us-east-1"  # Change this to your desired region
}

# VPC Data Source - using default VPC
data "aws_vpc" "default" {
  default = true
}

# AMI Data Source - Getting latest CentOS 7 AMI
data "aws_ami" "centos7" {
  most_recent = true
  owners      = ["679593333241"] # CentOS.org owner ID

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Security Group
resource "aws_security_group" "centos_sg" {
  name        = "centos_sg"
  description = "Security group for CentOS instance"
  vpc_id      = data.aws_vpc.default.id

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # WARNING: Restrict this to your IP in production
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "centos_security_group"
  }
}

# EC2 Instance
resource "aws_instance" "centos_instance" {
  ami           = data.aws_ami.centos7.id
  instance_type = "t2.micro"  # Change this as needed

  vpc_security_group_ids = [aws_security_group.centos_sg.id]
  key_name              = "your-key-pair-name"  # Replace with your key pair name

  root_block_device {
    volume_size = 20  # Size in GB
    volume_type = "gp2"
  }

  tags = {
    Name = "CentOS-7-Instance"
  }
}

# Output the instance's public IP
output "public_ip" {
  value = aws_instance.centos_instance.public_ip
}
