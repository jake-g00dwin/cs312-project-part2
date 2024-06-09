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

resource "aws_instance" "app_server" {
    // Amazon Linux AMI(2023)
    ami = "ami-00beae93a2d981137"
    instance_type = "t2.micro"

    tags = {
        Name = var.instance_name
    }
}

