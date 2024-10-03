terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("name of the credentials file, should be a .json file")

  project = "change your project ID here"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_compute_network" "vpc_network" {
  name = "network-1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "devopsmolvi-gcp-vm"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        disk = "disk1"
    }
  }
}
  network_interface {
	network = google_compute_network.vpc_network.name
  }
}
