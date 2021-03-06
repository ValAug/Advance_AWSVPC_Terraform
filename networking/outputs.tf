# -- networking outputs
output "pub_subnet_names" {
  description = "pub subnet id and vpc id"
  value       = [for i in aws_subnet.exos_pub_sub[*] : join(": ", [i.tags["Name"], i.vpc_id])]
}

output "pri_subnet_names" {
  description = "pri subnet id and vpc id"
  value       = [for i in aws_subnet.exos_pri_sub[*] : join(": ", [i.tags["Name"], i.vpc_id])]
}

output "pub_sub_ids" {
  value = [for i in aws_instance.exos_web[*] : join(":", [i.tags["Name"], i.subnet_id])]
}

output "public_dns" {
  description = "public ip of EC2 instances"
  value       = [aws_instance.exos_web[*].public_dns]
}

output "public_ip" {
  description = "public ip of EC2 instances"
  value       = [aws_instance.exos_web[*].public_ip]
}