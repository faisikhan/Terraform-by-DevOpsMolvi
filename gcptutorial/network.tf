resource "google_compute_network" "network1" {
  name                    = "network1"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "thefirewallrules" {
  name    = "thefirewallrules"
  network = google_compute_network.network1.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}

module "vm1" {
  source           = "./servers"
  vm_name          = "vm1"
  vm_zone          = "us-central1-a"
  instance_network = google_compute_network.network1.self_link
}

module "vm2" {
  source           = "./servers"
  vm_name          = "vm2"
  vm_zone          = "europe-west1-d"
  instance_network = google_compute_network.network1.self_link
}
