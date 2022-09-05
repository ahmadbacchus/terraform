terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket = "my-tf-test-backend-dev"
    key    = "Development/VM"
    region = "us-east-1"
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

#Create VPC
resource "aws_vpc" "main" {
  cidr_block = "172.30.0.0/16"
  tags = {
    Name = "My Custom VPC"

  }
}


#Create Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = aws_vpc.main.cidr_block
  tags = {
    Name = "Main"
  }
}

#Create Security group
resource "aws_security_group" "main" {
  name        = "Main-Security-group"
  description = "Main-Security-group"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "Main-Security-group"
  }
}

#Ingress security group rule
resource "aws_security_group_rule" "ingress-allow_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}

#Egress security group rule
resource "aws_security_group_rule" "egress-allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  security_group_id = aws_security_group.main.id
}

#Create EC2
resource "aws_instance" "app_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.main.id
  #key_name = var.key-name
  user_data = file("install_scripts/install.sh")
  tags = {
    Name        = var.tags-name
    Description = var.tags-descr
    Environment = var.tags-env
    Owner       = var.tags-owner
    test        = "myval"
  }
}

resource "null_resource" "register_with_opsview"{
  provisioner "local-exec" {
    command = "curl --location --request POST 'http://localhost:8080/job/pipeline_test/buildWithParameters?action=register&ip=${aws_instance.app_server.private_ip}'"
  }



  depends_on = [
    aws_instance.app_server
  ]
}

resource "null_resource" "register_with_cmdb"{
  provisioner "local-exec" {
    command = "curl --location --request POST 'http://localhost:8080/job/pipeline_test/buildWithParameters?action=register&ip=${aws_instance.app_server.private_ip}'"
  }



  depends_on = [
    aws_instance.app_server
  ]
}
