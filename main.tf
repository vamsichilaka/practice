terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"   # change if needed
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash

              yum update -y
              yum install -y docker

              systemctl start docker
              systemctl enable docker

              docker pull vamsi/myimage:v1

              docker run -d -p 80:5000 --name mycontainer vamsi/myimage:v1
              EOF

  tags = {
    Name = "MyDockerInstance"
  }
}
