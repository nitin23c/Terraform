terraform {
    backend "s3" {
        bucket = "awsgeek0-terraform-remote-state"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}