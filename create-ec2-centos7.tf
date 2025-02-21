terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami                  = "ami-07a3e4e203510f3eb"
  instance_type        = "t2.micro"
  subnet_id            = "subnet-01accd23d7dceb8f4"
  availability_zone    = "us-east-1a"
  iam_instance_profile = "Role-EC2-General-Access"
  vpc_security_group_ids       = ["sg-06fc5798520efeed9"] 
  key_name                     = "Access-RedHat-Servers"
  count                        = 2
  tags = {
    Name = "CentOS7-Instance"
  }
}
