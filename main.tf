# --- root - main.tf

module "networking" {
  source    = "./networking"
  vpc_count = 2
  
}