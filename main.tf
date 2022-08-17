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
  key_name = "ahmad"
  vpc_security_group_ids = ["sg-0226c0186ef0176b9"]
  user_data = file("install.sh")
  tags = {
    Name = var.tags-name
    Description = var.tags-descr
    Environment = var.tags-env
    Owner = var.tags-owner
  }
}