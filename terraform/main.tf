
locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name = "HelloWorld"
    Env   = "Prod"
    Project = "ABC"
    Dept = "Eng"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
# Fetch the default security group in the VPC
data "aws_security_group" "default" {
  vpc_id =   data.aws_vpc.default.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}
# Data source to get the default VPC
data "aws_vpc" "default" {
  default = true  # Fetches the default VPC
}
# Security Group definition
resource "aws_security_group" "dynamic_sg" {
  name        = "dynamic-sg"
  description = "Dynamic security group for HelloWorld project"
  vpc_id      =  data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.ingress_rules  # Ensure var.ingress_rules is defined as a list of maps
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  # Attach tags
  tags = local.common_tags
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = local.common_tags

}

resource "aws_instance" "wdbeb" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

    tags = local.common_tags

}
