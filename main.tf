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

  user_data = <<-EOF
#!/bin/bash

# update system
yum update -y

# install docker & git
yum install -y docker git

# start docker
systemctl start docker
systemctl enable docker

# allow ec2-user to use docker
usermod -aG docker ec2-user

# go to ec2-user home
cd /home/ec2-user

# clone your repo
git clone -b Dev https://github.com/vamsichilaka/practice.git

# go inside repo
cd practice

# build docker image
docker build -t studentapp:v1 .

# run container
docker run -d -p 8081:5000 --name studentdetails studentapp:v1

EOF

  tags = {
    Name = "myec2"
  }
}
