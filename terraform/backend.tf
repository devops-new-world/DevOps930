terraform {
  backend "s3" {
    bucket = "mydevops930bucket"
    key    = "tflab"
    region = "us-east-1"
  }
}
