resource "google_storage_bucket" "demo" {
  name          = "demo-bucket-playground-s-11-e68e54c3"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true
}

output "bucket_url" {
  value = google_storage_bucket.demo.url
}

resource "google_compute_network" "custom_vpc" {
  name                    = "sandbox-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom_subnet" {
  name          = "sandbox-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.custom_vpc.id
}

output "network_id" {
  value = google_compute_network.custom_vpc.id
}