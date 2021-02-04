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

variable "pub_sub_count" {
  description = "number of public subnet"
  type        = number
}

variable "public_cidrs" {
  type        = list(any)
  description = "Available cidr blocks for public subnets"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
    "10.0.9.0/24",
    "10.0.10.0/24",
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24",
    "10.0.14.0/24",
    "10.0.15.0/24",
    "10.0.16.0/24"
  ]
}