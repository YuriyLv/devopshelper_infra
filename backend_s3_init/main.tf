#____________________________________________backend
terraform {
  backend "s3" {
    region         = "ca-central-1"
    bucket         = "dev-ops-hel-per"
    key            = "state-bucket/terraform.tfstate"
    dynamodb_table = "dev-ops-hel-per"
  }
}

#____________________________________________Versioning
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.44.0, <=4.61.0"
    }
  }
  required_version = ">= 1.3.6, <= 1.4.4"
}

#____________________________________________Provider
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment_id
      Role        = "${var.environment_name}-State-bucket"
      Purpose     = var.purpose
    }
  }
}

#____________________________________________Dynamodb_table
resource "aws_dynamodb_table" "terraform_statelock" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

#____________________________________________S3
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "${var.environment_name} State bucket"
  }
}

#____________________________________________Versioning s3
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = var.state_bucket
  versioning_configuration {
    status = "Enabled"
  }
}

#____________________________________________Encripting
resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#____________________________________________Privacy
resource "aws_s3_bucket_acl" "state_bucket_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

#____________________________________________Lock public access
resource "aws_s3_bucket_public_access_block" "state_bucket" {
  bucket                   = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

