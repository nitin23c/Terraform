terraform {
  backend "s3" {
    bucket = "demo-terraform-remote-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
