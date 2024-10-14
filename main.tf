#########################################
# Specify the provider and access details
#########################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

###########################################
# Create a VPC to launch our instances into
###########################################
resource "aws_vpc" "demo-tfe" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "demo-tfe"
  }
}

###########################################################################
# Create an internet gateway to give our subnet access to the outside world
###########################################################################
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.demo-tfe.id
}

#######################################################
# Grant the VPC internet access on its main route table
#######################################################
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.demo-tfe.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

##############################
# Setup key for authentication
##############################
resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = var.public_key
}

##################
# Setup Web Subnet
##################
resource "aws_subnet" "web" {
  vpc_id                  = aws_vpc.demo-tfe.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Web"
  }
}

########################################
# List all availability zones to be used
########################################
data "aws_availability_zones" "available" {
}

########################
# Default Security group
########################
resource "aws_security_group" "default" {
  name        = "demo-tfe default sg"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.demo-tfe.id

  # SSH access from the VPC and LocalIP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16", "0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

##############
# Web Instance
##############
resource "aws_instance" "web-01" {
  tags = {
    Name = "web-01"
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.private_key
  }

  instance_type = "t2.micro"

  ami                    = var.aws_amis
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id              = aws_subnet.web.id

  provisioner "chef" {
    environment     = var.chef_environment
    run_list        = [var.server_runlist]
    node_name       = aws_instance.web-01.tags.Name
    server_url      = var.chef_server_url
    recreate_client = true
    version         = "13.12.3"
    user_name       = var.chef_username
    user_key        = var.chef_pem
  }
}