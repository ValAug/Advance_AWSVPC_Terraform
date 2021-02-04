# --- Networking module main

resource "random_string" "vpc_rs" {
    count = var.vpc_count
    length = 4
    special = true
    upper = true  
}