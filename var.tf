variable "vpc_addr" {}
variable "env" {}
variable "region" {}
variable "ec2_key" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "ansible_rsa_pub" {}

data "template_file" "ec2_userdata" {
  template = "${file("${path.module}/ec2-userdata.sh")}"
  vars {
		AWS_ACCESS_KEY_ID = "${var.AWS_ACCESS_KEY_ID}"
		AWS_SECRET_ACCESS_KEY = "${var.AWS_SECRET_ACCESS_KEY}"
		AWS_DEFAULT_REGION = "${var.region}"
    domain = "${var.env}.lab.io"
    ansible_rsa_pub = "${var.ansible_rsa_pub}"
  }
}

variable "ec2_inst" {
	type = "map"
	default = {
		type = "t2.micro",
		ami = "ami-005bdb005fb00e791"  # Ubuntu 18.04
	}
}

