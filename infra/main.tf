# Bucket to store a website

resource "google_storage_bucket" "website_bucket" {
  name = "example-website-freecodecamp-tutorial"
  location = "SOUTHAMERICA-EAST1"
}

# Make new object public

resource "google_storage_object_access_control" "public_rule" {
  object = google_storage_bucket_object.static_site_src.name
  bucket = google_storage_bucket.website_bucket.name
  role = "READER"
  entity = "allUsers"
}

# Upload the html file to the bucket

resource "google_storage_bucket_object" "static_site_src" {
  name = "index.html"
  source = "../website/index.html"
  bucket = google_storage_bucket.website_bucket.name
}

# Reserve a static external IP adress

resource "google_compute_global_address" "website_ip" {
  name = "website-lb-ip"
}

# Get the managed DNS Zone

data "google_dns_managed_zone" "dns_zone" {
  name = var.dns_zone_name
}

# Add the IP to the DNS

resource "google_dns_record_set" "website" {
  name = "website.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type = "A"
  ttl = 300
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  rrdatas = [google_compute_global_address.website_ip.address]
}

# Add the bucket as a CDN backend

resource "google_compute_backend_bucket" "website-backend" {
  name = "website-backend-bucket"
  bucket_name = google_storage_bucket.website_bucket.name
  description = "Containes files needed for the website"
  enable_cdn = true
}

# Create the URL map

resource "google_compute_url_map" "website" {
  name = "website-url-map"
  default_service = google_compute_backend_bucket.website-backend.self_link
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_backend_bucket.website-backend.self_link
  }
}

# GCP HTTP Proxy

resource "google_compute_target_http_proxy" "website-lb" {
  name = "website-target-proxy"
  url_map = google_compute_url_map.website.name
}

# GCP Forwarding rule

resource "google_compute_global_forwarding_rule" "default" {
  name = "website-forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_address = google_compute_global_address.website_ip.address
  ip_protocol = "TCP"
  port_range = "80"
  target = google_compute_target_http_proxy.website-lb.self_link
}