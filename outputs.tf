# --- root - outputs
output "vpc_info" {
  description = "vpc id"
  value       = [for x in module.networking[*] : x]
}