terraform {
  backend "gcs" {
    bucket = "jos-challenge-devsecops-la"
    prefix = "terraform/state"
  }
}