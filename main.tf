# --- root - main.tf

module "networking" {
  source    = "./networking"
  vpc_count = 2
  instaces_per_subnet = 1
  
}