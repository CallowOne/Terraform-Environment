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

resource "aws_instance" "centos7_server1" {
  ami                   = "ami-07a3e4e203510f3eb"
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

  user_data                    = <<EOF
  \#cloud-boothook
  \#!/bin/bash
  sudo echo "root:root" | chpasswd
  EOF


  tags = {
    Name = "CentOS7-Instance"
  }
}

resource "aws_instance" "centos7_server2" {
  ami                   = "ami-07a3e4e203510f3eb"
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

  user_data                    = <<EOF
  \#!/bin/bash
  sudo echo "root:root" | chpasswd
  EOF


  tags = {
    Name = "CentOS7-Instance"
  }
}