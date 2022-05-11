terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  key_name = "my-test-key-pair"

  user_data = <<-EOF
    #!/bin/bash
    echo "*** Installing apache2"
    sudo apt update -y
    sudo apt install apache2 -y
    echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "Ahmad-Web-1"
    Descr = "my test web server"
  }
}

output "instance_ip_addr" {
  value = ["${aws_instance.app_server.*.public_dns}","${aws_instance.app_server.*.private_ip}", "${aws_instance.app_server.tags}"]
  description = "The private IP address of the main server instance."
}