resource "aws_security_group" "allow_22_all" {
  name = "allow_22_all"
  description = "allow ssh port from all"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    Name = "${var.env}_allow_22_all"
  }
}

resource "aws_security_group" "allow_all_vpc" {
  name = "allow_all_vpc"
  description = "allow all port from VPC"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    cidr_blocks = [ "${var.vpc_addr}.0.0/16" ]
    from_port = 0
    to_port = 65535
    protocol = "tcp"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    Name = "${var.env}_allow_all_vpc"
  }
}

resource "aws_security_group" "allow_80_all" {
  name = "allow_80_all"
  description = "Allow HTTP"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    Name = "${var.env}_allow_80_all"
  }
}
