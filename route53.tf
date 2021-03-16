resource "aws_route53_zone" "zone" {
  name = "${var.env}.lab.io"
  comment = "Route53 for ${var.env}"
  vpc {
    vpc_id = "${aws_vpc.vpc.id}"
  }
}
