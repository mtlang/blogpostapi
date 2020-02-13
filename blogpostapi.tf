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

data "aws_ami" "linux2" {
    most_recent = true

    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm*"]
    }
}

resource "aws_instance" "db_instance" {
    ami = data.aws_ami.linux2.image_id
    associate_public_ip_address = false
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = ["foo"]
    subnet_id = var.subnet_id
}