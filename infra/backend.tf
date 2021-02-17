terraform {
  backend "s3" {
    bucket = "ak-terraform-state-files"
    region = "us-east-1"
  }
}