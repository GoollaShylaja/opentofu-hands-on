data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "test_instance" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  associate_public_ip_address = true

  user_data = <<-EOF
             #!/bin/bash
             sudo yum update -y
             sudo amazon-linux-extras- install docker -y
             sudo service docker start
             sudo username -a -G docker ec2-user
             sudo docker run -d -p 80:80 nginx

             EOF

  tags = {
    Name = "OpenTofu-EC2"
  }
}