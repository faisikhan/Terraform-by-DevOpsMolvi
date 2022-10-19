terraform {                    # the terraform block starts here.
  required_providers {         # the providers can be google, aws, azure, gcp. Full list here: https://registry.terraform.io/browse/providers
    google = {                 # We are using google as our provider here since we are building infrastructure on GCP.
      source  = "hashicorp/google"      # The source is picked from here: https://registry.terraform.io/providers/hashicorp/google/latest
      version = "4.41.0"       # current version being used.
    }
  }
}

provider "google" {            # We are using google as our main provider.
  
  credentials = file("faisal-iam-219c01f14ea2.json")      # We have to create a service account first to provide IAM access for GCP compute resources. Copy the 
                                                          #  contents of that json file because it contains the credentials in the Terraform directory. 

  project = "faisal-iam"      # Project ID on GCP. The infrastructure will be created in that project. 
  region  = "us-central1"     # The region in which our infrastructure will be created.
  zone    = "us-central1-c"   # and so the zone.
}


resource "google_compute_network" "vpc_network" {         # It will create a brand new network with subnets in all GCP regions, the name will be network-1.
  name = "network-1"
}

resource "google_compute_instance" "vm_instance" {        # We are creating our first VM on GCP with machine type, OS, it's name and other necessary information.
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
