resource "aws_vpc" "vpc" {
  cidr_block       = "${var.vpc_addr}.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.env}-vpc"
  }
}
# NAT Setting
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "${var.env}-nat-ip"
  }
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${aws_subnet.subnet-jmp.id}"
  tags = {
    Name = "${var.env}-nat-gw"
  }
}
resource "aws_route_table" "private-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.env}-route-private"
  }
}
resource "aws_route" "nat-route" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  route_table_id = "${aws_route_table.private-route-table.id}"
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.env}-igw"
  }
}
resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.env}-route-public"
  }
}

resource "aws_route" "public-route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

output "nat-ip" {
  value = "${aws_eip.nat.public_ip}"
}
