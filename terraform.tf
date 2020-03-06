# Terraform
# Build web sever

provider "aws" {
    region = "us-east-2"
   
}

resource "aws_instance" "web_server_test" {
  ami = "ami-0fc20dd1da406780b" # aws
  instance_type = "t2.micro"
  key_name = "MyKeyPair"
  vpc_security_group_ids = [aws_security_group.web_server_test.id]
  user_data = file("bash.sh")

  tags =  {
    Name = "AWS server"
    Owner = "Artem Minaev"
    Project = "Terraform test"
  }
}

resource "aws_security_group" "web_server_test" {
  name        = "web server security group"
  description = "Allow 80,433,8080,22 tcp"


  dynamic "ingress"{
    for_each = ["80","22","8080","443"]
    content{
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}



output "instance_ips" {
value = "${aws_instance.web_server_test.public_ip}"
}
