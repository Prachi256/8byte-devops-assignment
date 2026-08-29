terraform {
  backend "s3" {
    bucket       = "8byte-devops-tfstate-013200615806"
    key          = "8byte-devops-assignment/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}