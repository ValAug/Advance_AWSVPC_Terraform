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
  count                   = var.pub_sub_count
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
  count  = var.vpc_count
  vpc_id = aws_vpc.exos_vpc[count.index].id


  tags = {
    "Name" = "exos_rt_pub"
  }

}
resource "aws_route" "exos_default_rt" {
  count                  = var.vpc_count
  route_table_id         = aws_route_table.exos_public_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.exos_gw[count.index].id

}

resource "aws_route_table_association" "exos_pub_access" {
  count          = var.pub_sub_count
  route_table_id = aws_route_table.exos_public_rt[count.index].id
  subnet_id      = aws_subnet.exos_pub_sub.*.id[count.index]


}
resource "aws_instance" "exos_web" {
  count                       = var.instaces_per_subnet
  ami                         = var.ami
  instance_type               = var.type
  subnet_id                   = aws_subnet.exos_pub_sub.*.id[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.exos_web_sg[count.index].id]
  depends_on                  = [aws_internet_gateway.exos_gw]


  user_data = <<-EOF
        #!/bin/bash
        yum update -y
        amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
        yum install -y httpd mariadb-server
        systemctl start httpd
        systemctl enable httpd
        usermod -a -G apache ec2-user
        chown -R ec2-user:apache /var/www
        chmod 2775 /var/www
        find /var/www -type d -exec chmod 2775 {} \;
        find /var/www -type f -exec chmod 0664 {} \;
        echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
    EOF

  tags = {
    Name = "My_web"
  }
}

resource "aws_security_group" "exos_web_sg" {
  count       = var.instaces_per_subnet
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

resource "aws_internet_gateway" "exos_gw" {
  count  = var.vpc_count
  vpc_id = aws_vpc.exos_vpc[count.index].id

  tags = {
    Name = "exos_vpc_internet_gateway"
  }
}