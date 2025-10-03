provider "aws" {
	region = "us-east-1"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

resource "aws_instance" "mysql_server" {
	ami             = "ami-08c40ec9ead489470"
	instance_type   = "t2.micro"
	key_name        = var.key_name
	security_groups = [aws_security_group.mysql_sg.name]

	tags = {
		Name = "mysql-server"
	}
}

resource "aws_security_group" "mysql_sg" {
	name = "mysql-sg"
	description = "Allow SSH and MySQL access"

	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port   = 3306
		to_port     = 3306
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

output "mysql_public_ip" {
	value = aws_instance.mysql_server.public_ip
}