locals {
  project_id = "angelic-digit-302818"
  location   = "southamerica-east1"
}

resource "google_service_account" "cloud_run_service_account" {
  account_id   = "sa-run-challenge-api"
  display_name = "Service Account for Cloud Run"
}

module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.10.0"

  service_name           = "run-challenge-api"
  project_id             = local.project_id
  location               = local.location
  image                  = "gcr.io/cloudrun/hello"
  service_account_email  = google_service_account.cloud_run_service_account.email
  members = [
    "allUsers"
  ]
}

module "artifact_registry" {
  source  = "GoogleCloudPlatform/artifact-registry/google"
  version = "~> 0.1"

  project_id    = local.project_id
  location      = local.location
  format        = "docker"
  repository_id = "run-challenge-api"
  members = {
    "readers" = ["serviceAccount:${google_service_account.cloud_run_service_account.email}"]
  }
}