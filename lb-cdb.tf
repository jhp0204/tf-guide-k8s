resource "aws_lb" "cdb-lb" {
  name               = "${var.env}-cdb-lb"
  subnets            = [ "${aws_subnet.subnet-front-1.id}", "${aws_subnet.subnet-front-2.id}" ]
  internal           = true
  load_balancer_type = "network"

  # listener {
  #   instance_port     = 80
  #   instance_protocol = "http"
  #   lb_port           = 80
  #   lb_protocol       = "http"
  # }

  # cross_zone_load_balancing   = true
  # idle_timeout                = 400
  # connection_draining         = true
  # connection_draining_timeout = 400
  # security_groups             = [ "${aws_security_group.allow_all_vpc.id}", "${aws_security_group.allow_80_all.id}" ]

  tags = {
    Name = "${var.env}-cdb-lb"
  }
}

resource "aws_lb_listener" "cdb-lb" {
  load_balancer_arn = "${aws_lb.cdb-lb.arn}"
  port              = "26257"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.cdb-lb.arn}"
  }
}

resource "aws_lb_target_group" "cdb-lb" {
  name     = "${var.env}-cdb-lb-target"
  port     = 26257
  protocol = "TCP"
  vpc_id   = "${aws_vpc.vpc.id}"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    # timeout             = 3
    port                = 26257
    interval            = 30
  }

}

resource "aws_route53_record" "cdb-lb" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "${var.env}-cdb-lb.${var.env}.lab.io"
  type = "CNAME"
  ttl = 300
  records = [ "${aws_lb.cdb-lb.dns_name}" ]
}

output "cdb-lb-domain" {
  value = "${aws_lb.cdb-lb.dns_name}"
}
