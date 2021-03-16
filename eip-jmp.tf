resource "aws_eip" "jmp-01-eip" {
  vpc = true
  instance = "${aws_instance.jmp-01.id}"
  
  tags = {
    Name = "${var.env}-jmp-eip"
  }
}

output "jmp-01-eip" {
  value = "${aws_eip.jmp-01-eip.public_ip}"
}
