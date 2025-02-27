terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "networking/terraform.tfstate"
    region         = "us-west-1"
    encrypt        = true
  }
}
