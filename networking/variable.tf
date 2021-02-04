# --- Networking module variables

variable "vpc_count" {
  description = "Numbers of vpc to be deploy with their random string names"
  type        = number

  validation {
    condition     = var.vpc_count <= 4 && var.vpc_count >= 1
    error_message = "The amount of vpc's must be valid range 1 - 3."

  }

}

variable "vpc_cidr" {
  description = "cidr for VPC"
  type        = string
  default     = "10.0.0.0/16"
}