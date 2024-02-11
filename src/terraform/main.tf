locals {
  project_id = "angelic-digit-302818"
  location   = "southamerica-east1"
}

module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.10.0"

  service_name           = "run-challenge-api"
  project_id             = local.project_id
  location               = local.location
  image                  = "gcr.io/cloudrun/hello"
  members = [
    "allUsers"
  ]
}