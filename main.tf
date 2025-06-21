provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-insecure-devsecops-bucket"
  acl    = "public-read"  # ❌ This will trigger a Checkov finding
}