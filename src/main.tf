// Author: Jake G
// Date: 2024
// Filename: main.tf

// Creating a minecraft server
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


// This setup for the provider assumes you have a credentials file.
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


// Setup for the VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "minecraft-vpc"
  }
}


// Setup the subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}


// Setup gateway, we need the net up in here
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}


// Need a routing table too
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}


resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}


// Setup the Security group for it.
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
  name   = "mcsg"

  // Allow inbound SSH traffic
  // I guess I could change the port if I felt fancy meh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow the minecraft server connections
  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "mcsg"
  }
}

// Create the Instance
resource "aws_instance" "minecraft" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = var.key_name 

  tags = {
    Name = var.instance_name
  }

  depends_on = [aws_security_group.main]
}

