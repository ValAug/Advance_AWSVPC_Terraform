# --- root - main.tf

module "networking" {
  source    = "./networking"
  vpc_count = 1
  pub_sub_count = 1
  instaces_per_subnet = 1
  
}