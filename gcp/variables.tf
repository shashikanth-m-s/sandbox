variable "project_id" {
  type        = string
  default     = "playground-s-11-e68e54c3"
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Primary sandbox region"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
  description = "Primary sandbox zone"
}