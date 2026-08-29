data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "app" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2.name

  subnet_id = aws_subnet.public[0].id

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash

              apt-get update -y
              apt-get install -y docker.io

              systemctl enable docker
              systemctl start docker

              usermod -aG docker ubuntu

              docker pull nginx:alpine

              docker run -d \
                --name app \
                --restart unless-stopped \
                -p 5000:80 \
                nginx:alpine
              EOF

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name    = "${var.project_name}-app"
    Project = var.project_name
  }
}