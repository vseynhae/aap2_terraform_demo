terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = "eu-central-1"
}

# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "tf-demo-aws-ec2-instance-1" {
  ami           = "ami-00513967e6b47e386"
  instance_type = "t3.medium"
  tags = {
    Name = "tf-demo-aws-ec2-instance-1"
  }

}
