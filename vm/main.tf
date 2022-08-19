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
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key-name
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data = file("install.sh")
  tags = {
    Name = var.tags-name
    Description = var.tags-descr
    Environment = var.tags-env
    Owner = var.tags-owner
  }
}