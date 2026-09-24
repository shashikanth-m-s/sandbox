terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# The provider reads credentials automatically from GOOGLE_APPLICATION_CREDENTIALS
provider "google" {
  project = "playground-s-11-e68e54c3"
  region  = "us-central1"
}