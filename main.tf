terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0e670eb768a5fc3d4" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name = "terraform"

  tags = {
    Name = "myec2"
  }
}
