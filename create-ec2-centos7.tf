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

resource "aws_instance" "rhel9_server1" {
  ami                   = "ami-001a8b08763eac3b8"
  instance_type         = "t2.micro"
  subnet_id             = var.private-subnet-10-0-128-0
  private_ip            = var.private-ip-1
  availability_zone     = "us-east-1a"
  iam_instance_profile  = var.iam-role
  vpc_security_group_ids       =  var.security-group
  key_name                     =  var.key-pair

  root_block_device {
    delete_on_termination = true
  }
  user_data                    = file("user_data")
  tags = {
    Name = "RHEL9-Instance"
  }
}

resource "aws_instance" "rhel9_server2" {
  ami                   = "ami-001a8b08763eac3b8"
  instance_type         = "t2.micro"
  subnet_id             = var.private-subnet-10-0-128-0
  private_ip            = var.private-ip-2
  availability_zone     = "us-east-1a"
  iam_instance_profile  = var.iam-role
  vpc_security_group_ids       =  var.security-group
  key_name                     =  var.key-pair
  root_block_device {
    delete_on_termination = true
  }
  tags = {
    Name = "RHEL9-Instance"
  }
}