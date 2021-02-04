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
  count                   = var.vpc_count
  vpc_id                  = aws_vpc.exos_vpc[count.index].id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "exos_pub_sub - ${count.index + 1}"
  }

}

resource "aws_subnet" "exos_pri_sub" {
  count                   = var.vpc_count
  vpc_id                  = aws_vpc.exos_vpc[count.index].id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false

  tags = {
    "Name" = "exos_pri_sub - ${count.index + 1}"
  }

}

resource "aws_instance" "web" {
  count = var.instaces_per_subnet
  ami           = var.ami
  instance_type = var.type
  subnet_id     = aws_subnet.exos_pub_sub.*.id[count.index]

#   user_data = <<-EOF
#     #!/bin/bash
#     sudo yum update -y
#     sudo yum install httpd -y
#     sudo systemctl enable httpd
#     sudo systemctl start httpd
#     echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
#     EOF

  tags = {
    Name = "My_web"
  }
}
