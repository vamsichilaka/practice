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
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io git

              systemctl start docker
              systemctl enable docker

              cd /home/ubuntu
              git clone https://github.com/suysuyua/practice.git

              cd practice
              docker build -t studentimage .
              docker run -d -p 5000:5000 --name mystudent studentimage
              EOF

  tags = {
    Name = "MyDockerInstance"
  }
}
