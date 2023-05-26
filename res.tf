resource "aws_key_pair" "dep" {
  key_name   = "deployer-key"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "sivam" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.dep.key_name
  vpc_security_group_ids = ["${aws_security_group.shivam_sg.id}"]
  tags = {
    Name = "shivam"
  }
user_data = file("${path.module}/script.sh")

}

output "key--name" {
  value = aws_key_pair.dep.key_name
}
output "private_ip" {
  value = aws_instance.sivam.public_ip
}
