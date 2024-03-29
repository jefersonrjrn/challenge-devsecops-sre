module "project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = [local.project_id]
  mode     = "additive"

  bindings = {
    "roles/bigquery.metadataViewer" = [
      "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
    ]
    "roles/bigquery.dataEditor" = [
      "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
    ]
    "roles/bigquery.dataViewer" = [
      "serviceAccount:${google_service_account.cloud_run_service_account.email}"
    ]
    "roles/bigquery.user" = [
      "serviceAccount:${google_service_account.cloud_run_service_account.email}"
    ]
  }
}