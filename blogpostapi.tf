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

data "aws_ami" "linux2" {
    most_recent = true

    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm*"]
    }
}

resource "aws_security_group" "db_security_group" {
    name = "blogpostapi-db-sg"

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = [var.dev_cidr]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "blogpost-api-db-sg"
    }
}

resource "aws_instance" "db_instance" {
    ami = data.aws_ami.linux2.image_id
    associate_public_ip_address = false
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.db_security_group.id]
    subnet_id = var.subnet_id
}