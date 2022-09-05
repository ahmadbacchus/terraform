terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket = "my-tf-test-backend-dev"
    key    = "Development/RDS"
    region = "us-east-1"
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.medium"
  db_name              = var.tags-name
  identifier = var.tags-name
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true


    #Register the machione with service 1
  provisioner "local-exec" {
    command = "curl --location --request POST 'http://localhost:8080/job/pipeline_test/buildWithParameters?action=register&ip=${self.endpoint}'"
  }

  provisioner "local-exec" {
    when = destroy
    command = "curl --location --request POST 'http://localhost:8080/job/pipeline_test/buildWithParameters?action=de-register&ip=${self.endpoint}'"
  }

  #Register the machione with service 2
  provisioner "local-exec" {
    command = "curl --location --request POST 'http://localhost:8080/job/pipeline_test/buildWithParameters?action=register&ip=${self.endpoint}'"
  }

  provisioner "local-exec" {
    when = destroy
    command = "curl --location --request POST 'http://localhost:8080/job/pipeline_test/buildWithParameters?action=de-register&ip=${self.endpoint}'"
  }

  #Register the machione with service 3
  provisioner "local-exec" {
    command = "curl --location --request POST 'http://localhost:8080/job/pipeline_test/buildWithParameters?action=register&ip=${self.endpoint}'"
  }

  provisioner "local-exec" {
    when = destroy
    command = "curl --location --request POST 'http://localhost:8080/job/pipeline_test/buildWithParameters?action=de-register&ip=${self.endpoint}'"
  }
}