resource "aws_lb" "ngw-lb" {
  name               = "${var.env}-ngw-lb"
  subnets            = [ "${aws_subnet.subnet-public-1.id}", "${aws_subnet.subnet-public-2.id}" ]
  internal           = false
  load_balancer_type = "application"

  # listener {
  #   instance_port     = 80
  #   instance_protocol = "http"
  #   lb_port           = 80
  #   lb_protocol       = "http"
  # }

  # cross_zone_load_balancing   = true
  idle_timeout                = 400
  # connection_draining         = true
  # connection_draining_timeout = 400
  security_groups             = [ "${aws_security_group.allow_all_vpc.id}", "${aws_security_group.allow_80_all.id}" ]

  tags = {
    Name = "${var.env}-ngw-lb"
  }
}

resource "aws_lb_listener" "ngw-lb" {
  load_balancer_arn = "${aws_lb.ngw-lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ngw-lb.arn}"
  }
}

resource "aws_lb_target_group" "ngw-lb" {
  name     = "${var.env}-ngw-lb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc.id}"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    path                = "/health"
    interval            = 30
  }
}

resource "aws_route53_record" "ngw-lb" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "${var.env}-ngw-lb.${var.env}.lab.io"
  type = "CNAME"
  ttl = 300
  records = [ "${aws_lb.ngw-lb.dns_name}" ]
}

output "ngw-lb-domain" {
  value = "${aws_lb.ngw-lb.dns_name}"
}
