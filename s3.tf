provider "aws" {
  region = "us-east-1" # Change to your preferred AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"  # Change this to a globally unique name
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}

