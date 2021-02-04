# -- networking outputs
output "pub_subnet_names" {
  description = "pub subnet id and vpc id"
  value       = [for i in aws_subnet.exos_pub_sub[*] : join(": ", [i.tags["Name"],i.vpc_id])]
}

output "pri_subnet_names" {
  description = "pri subnet id and vpc id"
  value       = [for i in aws_subnet.exos_pri_sub[*] : join(": ", [i.tags["Name"],i.vpc_id])]
}