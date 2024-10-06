// Configure the Google Cloud provider
provider "google" {
  credentials = file("${var.creds}")
  project     = var.myproject
  region      = var.region
}

// Create VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = "false"
}

// Create Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}-subnet"
  ip_cidr_range = var.subnet_cidr
  network       = "${var.name}-vpc"
  depends_on    = ["google_compute_network.vpc"]
  region        = var.region
}

// VPC firewall configuration
resource "google_compute_firewall" "firewall" {
  name    = "${var.name}-firewall"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]

}
// Create a new GCP Instance

resource "google_compute_instance" "vm_instance" {
  name         = var.server
  machine_type = var.machinetype
  zone         = var.zone
  tags         = ["web", "dev"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        disk = "disk1"
      }
    }
  }
  metadata = {
    ssh-keys = "${var.gcp_ssh_user}:${file(var.gcp_ssh_pub_key_file)}"
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = "${var.name}-subnet"
    access_config {
    }
  }
}
