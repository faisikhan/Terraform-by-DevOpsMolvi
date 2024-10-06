resource "google_storage_bucket" "auto-expire" {
  name          = var.bucket_name
  storage_class = var.storage_class
  location      = var.bucket_location
  force_destroy = true
  uniform_bucket_level_access = true

   versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      num_newer_versions = 3
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket_object" "picture" {
  name = "myimage"
  bucket = "pizzaimages"
  source = "pizza.png"  
}
