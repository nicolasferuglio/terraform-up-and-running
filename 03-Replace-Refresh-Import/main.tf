provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "rm_instance" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-rm"
  }
}

resource "aws_instance" "refresh_instance" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-refresh"
  }
}

resource "aws_s3_bucket" "bucket" {
    bucket = "mybucket-001122334455"
}