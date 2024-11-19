terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "dev" {
    count = 3
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev-${count.index}"
    }
    vpc_security_group_ids = ["sg-0b7caab3a5fc05e33"]
}

resource "aws_security_group" "acesso-ssh" {
    name = "acesso-ssh"
    description = "Allow SSH"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["187.19.242.59/32"]
    }

    tags = {
        Name = "ssh"
    }
}