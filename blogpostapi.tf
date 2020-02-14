provider "aws" {
    region = var.aws_region
}

variable "instance_type" {
  type = string
  default = "t3.nano"
}

variable "subnet_id" {
    type = string
}

variable "key_name" {
    type = string
}

variable "aws_region" {
    type = string
}

variable "dev_cidr" {
    type = string
}

output "instance_ip_address" {
    value = aws_instance.server_instance.public_ip
}

data "aws_ami" "linux2" {
    most_recent = true

    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm*"]
    }
}

resource "aws_security_group" "server_security_group" {
    name = "blogpostapi-server-sg"

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = [var.dev_cidr]
    }

    ingress {
        from_port       = 5000
        to_port         = 5000
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "blogpostapi-server-sg"
    }
}

resource "aws_instance" "server_instance" {
    ami = data.aws_ami.linux2.image_id
    associate_public_ip_address = true
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.server_security_group.id]
    subnet_id = var.subnet_id

    tags = {
        Name = "blogpostapi-server"
    }
}
