# --- Networking module main

resource "random_string" "vpc_rs" {
  count   = var.vpc_count
  length  = 4
  special = true
  upper   = true
}

resource "aws_vpc" "exos_vpc" {
  count      = var.vpc_count
  cidr_block = var.vpc_cidr
  tags = {
    Name = join(" - ", ["exos_vpc", random_string.vpc_rs[count.index].result])
  }
}

resource "aws_subnet" "exos_pub_sub" {
  count      = var.pub_sub_count
  vpc_id     = aws_vpc.exos_vpc[count.index].id
  cidr_block = var.public_cidrs[count.index]

}