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

resource "aws_s3_bucket" "backend" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.backend.id
  acl    = "private"
}