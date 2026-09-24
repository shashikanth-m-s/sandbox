terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  # Store state remotely in the GCS bucket created in the previous run
  backend "gcs" {
    bucket = "assets-playground-s-11-e68e54c3"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "playground-s-11-e68e54c3"
  region  = "us-central1"
  zone    = "us-central1-a"
}