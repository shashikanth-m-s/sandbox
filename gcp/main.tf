# ============================================================
# 0. AUTOMATED IMPORTS FOR ALREADY-CREATED RESOURCES
# ============================================================
import {
  to = google_storage_bucket.assets
  id = "assets-playground-s-11-e68e54c3"
}

import {
  to = google_compute_address.vm_static_ip
  id = "projects/playground-s-11-e68e54c3/regions/us-central1/addresses/sandbox-web-ip"
}

import {
  to = google_compute_network.vpc
  id = "projects/playground-s-11-e68e54c3/global/networks/sandbox-vpc"
}

import {
  to = google_compute_firewall.allow_web
  id = "projects/playground-s-11-e68e54c3/global/firewalls/sandbox-allow-web-ssh"
}

import {
  to = google_compute_subnetwork.subnet
  id = "projects/playground-s-11-e68e54c3/regions/us-central1/subnetworks/sandbox-subnet-uscentral1"
}

# ============================================================
# DATA SOURCE: Latest Debian 12 Bookworm Image
# ============================================================
data "google_compute_image" "debian12" {
  family  = "debian-12"
  project = "debian-cloud"
}

# ============================================================
# 1. NETWORKING: Custom VPC & Regional Subnet
# ============================================================
resource "google_compute_network" "vpc" {
  name                    = "sandbox-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "sandbox-subnet-uscentral1"
  ip_cidr_range = "10.10.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}

# ============================================================
# 2. FIREWALL: Allow External HTTP (80) & SSH (22)
# ============================================================
resource "google_compute_firewall" "allow_web" {
  name    = "sandbox-allow-web-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# ============================================================
# 3. PUBLIC IP: Static External IP for the VM
# ============================================================
resource "google_compute_address" "vm_static_ip" {
  name   = "sandbox-web-ip"
  region = var.region
}

# ============================================================
# 4. COMPUTE ENGINE: e2-micro VM running Nginx
# ============================================================
resource "google_compute_instance" "web_server" {
  name         = "gcp-web-demo"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["web-server"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian12.self_link
      size  = 20
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id

    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    echo "<h1>Welcome to Google Cloud Platform!</h1><p>Deployed from Azure DevOps Pipelines via Terraform.</p>" > /var/www/html/index.html
    systemctl restart nginx
  EOF
}

# ============================================================
# 5. STORAGE: Cloud Storage Bucket for assets
# ============================================================
resource "google_storage_bucket" "assets" {
  name          = "assets-${var.project_id}"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true
}