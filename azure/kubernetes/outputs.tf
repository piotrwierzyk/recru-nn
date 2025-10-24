output "hello_world_url" {
  description = "URL to access hello-world application"
  value       = "http://${var.appgw_public_ip}"
}

