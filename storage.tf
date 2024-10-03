provider "google" {
  project = "terraform-354707"
  region  = "europe-west3"
  version = "6.5.0"
}
resource "google_storage_bucket" "state-bucket" {
  name     = "devopsbucket1"
  location = "EU"
  versioning {
    enabled = true
  }
}
terraform {
  backend "gcs" {
    bucket = "devopsbucket2"
  }
}
resource "google_cloud_run_service" "nginx-service" {
  name     = "nginx-service"
  location = "europe-west3"
  template {
    spec {
      containers {
        image = "marketplace.gcr.io/google/nginx1"
        ports {
          container_port = 80
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "member" {
  location = google_cloud_run_service.nginx-service.location
  project  = google_cloud_run_service.nginx-service.project
  service  = google_cloud_run_service.nginx-service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
