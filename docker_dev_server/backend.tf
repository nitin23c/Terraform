terraform {
  backend "s3" {
    bucket = "demo-terraform-bucket"
    key    = "docker-infra/terraform.tfstate"
    region = "us-east-1"
  }
}
