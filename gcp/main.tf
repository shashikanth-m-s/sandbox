resource "google_storage_bucket" "demo" {
  name          = "demo-bucket-playground-s-11-e68e54c3"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true
}

output "bucket_url" {
  value = google_storage_bucket.demo.url
}