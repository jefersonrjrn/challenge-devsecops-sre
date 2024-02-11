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

resource "google_cloudbuild_trigger" "cloud_run_trigger" {
name = "run-challenge-api-trigger"
included_files = ["src/api/**"]

  trigger_template {
    branch_name = "main"
    repo_name   = "github_jefersonrjrn_challenge-devsecops-sre"
  }

  filename = "src/api/cloudbuild.yaml"
}

module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 7.0"

  dataset_id                  = "ds_challenge"
  dataset_name                = "ds_challenge"
  description                 = "Dataset for DevSecOps/SRE Challenge"
  project_id                  = local.project_id
  location                    = "US"

  tables = [
  {
    table_id           = "flights",
    schema             =  file("bigquery/schema.json"),
    time_partitioning  = null,
    range_partitioning = null,
    expiration_time = null,
    clustering      = [],
    labels          = {},
  }
  ]
}