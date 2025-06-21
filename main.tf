provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-insecure-devsecops-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "example_acl" {
  bucket = aws_s3_bucket.example.id
  acl    = "public-read"  # ❌ This is insecure — Checkov will flag it
}