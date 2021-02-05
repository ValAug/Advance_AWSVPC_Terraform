# --- Networking module main

resource "random_string" "vpc_rs" {
  count   = var.vpc_count
  length  = 4
  special = true
  upper   = true
}

resource "aws_vpc" "exos_vpc" {
  count                = var.vpc_count
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = join(" - ", ["exos_vpc", random_string.vpc_rs[count.index].result])
  }
}

resource "aws_subnet" "exos_pub_sub" {
  count                   = var.vpc_count
  vpc_id                  = aws_vpc.exos_vpc[count.index].id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = false

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

resource "aws_route_table" "exos_public_rt" {
  count = var.vpc_count
  vpc_id = aws_vpc.exos_vpc[count.index].id

  tags = {
    "Name" = "exos_rt_pub"
  }

}
resource "aws_route" "exos_default_rt" {
  count = var.vpc_count
  route_table_id         = aws_route_table.exos_public_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw[count.index].id

}
resource "aws_instance" "web" {
  count                       = var.instaces_per_subnet
  ami                         = var.ami
  instance_type               = var.type
  subnet_id                   = aws_subnet.exos_pub_sub.*.id[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.web_sg[count.index].id]
  depends_on = [aws_internet_gateway.gw]
 

  user_data = <<-EOF
        #!/bin/bash
        sudo yum update -y
        sudo install -y httpd.x86_64
        sudo systemctl start httpd.service
        sudo systemctl enable httpd.service
        sudo echo "Hello Terraform $(hostname -f)" > /var/www/html/index.html
    EOF

  tags = {
    Name = "My_web"
  }
}

resource "aws_security_group" "web_sg" {
  count = var.vpc_count
  name        = "web_sg"
  description = "Security group for pub  access"
  vpc_id      = aws_vpc.exos_vpc[count.index].id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "gw" {
  count = var.vpc_count
  vpc_id = aws_vpc.exos_vpc[count.index].id

  tags = {
    Name = "exos_vpc_internet_gateway"
  }
}