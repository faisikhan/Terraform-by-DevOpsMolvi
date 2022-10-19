terraform {                    # the terraform block starts here.
  required_providers {         # the providers can be google, aws, azure, gcp. Full list here: https://registry.terraform.io/browse/providers
    google = {                 # We are using google as our provider here since we are building infrastructure on GCP.
      source  = "hashicorp/google"      # The source is picked from here: https://registry.terraform.io/providers/hashicorp/google/latest
      version = "4.41.0"       # current version being used.
    }
  }
}

provider "google" {            # We are using google as our main provider.
  
  credentials = file("faisal-iam-219c01f14ea2.json")      # We have to create a service account first to provide IAM access for GCP compute resources.

  project = "faisal-iam"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_compute_network" "vpc_network" {
  name = "network-1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "faisal-gcp-vm"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]
  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
