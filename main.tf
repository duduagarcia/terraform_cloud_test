terraform {
  cloud {
    organization = "csw24"

    workspaces {
      name = "value"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "cloud_test" {
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "t2.micro"

    # vpc_security_group_ids = [aws_security_group.api_access.id]

    # key_name = aws_key_pair.my_key_pair.key_name
    tags = {
      Name = "ec2-cloud_test"
    }

      user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get update -y
        sudo apt-get install -y docker-ce
        sudo usermod -aG docker ubuntu
        sudo systemctl enable docker
        sudo systemctl start docker
    EOF
}