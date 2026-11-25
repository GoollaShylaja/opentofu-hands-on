# 1. Create the Security Group container
resource "aws_security_group" "test_sg" {

  // here name and name and description,tags is attributes but ingress is block there is no equals to after the variable name
  name        = "${var.name_prefix}-ssh-http-sg"
  description = "Allow HTTP, HTTPS, and SSH inbound traffic"
  //vpc_id      = "vpc-12345678" # Replace with your VPC ID or reference (e.g., aws_vpc.main.id)

  tags = {
    Name = "${var.name_prefix}-ssh-http-sg"
  }

  // in coming traffic- ingress block 
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow from anywhere 

  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow from anywhere 

  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow from anywhere 

  }

  //out going
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # allow all outbound traffic 
  }

}
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "test_instance" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  key_name = aws_key_pair.this.key_name

 user_data = <<-EOF
        #!/bin/bash
        dnf update -y
        dnf install docker -y
        systemctl start docker
        systemctl enable docker
        usermod -a -G docker ec2-user
        docker run -d -p 80:80 nginx
    EOF

  tags = {
    Name = "OpenTofu-EC2"
  }
}
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096

}

resource "aws_key_pair" "this" {
  key_name   = "${var.name_prefix}_ssh"
  public_key = tls_private_key.this.public_key_openssh
}