resource "aws_key_pair" "ec2-key" {
  key_name = "${var.env}-key"
  public_key = "${var.ec2_key}"
}
