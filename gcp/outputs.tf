output "website_url" {
  description = "Public URL to access the deployed web server"
  value       = "http://${google_compute_address.vm_static_ip.address}"
}

output "storage_bucket_url" {
  description = "GCS bucket URL"
  value       = google_storage_bucket.assets.url
}