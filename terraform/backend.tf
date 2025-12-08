terraform {
  backend "s3" {
    bucket         = "neon-proj-state-bucket"
    key            = "neon-proj/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}