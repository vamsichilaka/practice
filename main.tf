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
              yum update -y

              # Install Docker and Git
              yum install -y docker git

              # Start Docker
              systemctl start docker
              systemctl enable docker

              # Give Docker some time to start
              sleep 10

              # Clone your repository
              cd /home/ec2-user
              git clone https://github.com/suysuyua/practice.git

              cd practice

              # Build Docker image
              docker build -t studentimage .

              # Run container
              docker run -d -p 5000:5000 --name mystudent studentimage
              EOF

  tags = {
    Name = "MyDockerInstance"
  }
}
