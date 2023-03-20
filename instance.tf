resource "aws_instance" "lms-instance" {
  ami                    = "ami-0ce70b86fc60c5c60"
  instance_type          = "t2.micro"
  key_name               = "osaka"
  subnet_id              = aws_subnet.lms--subnet.id
  vpc_security_group_ids = [aws_security_group.lms-nsg.id]
  # availability_zone = "ap-northeast-3a"
  user_data = file("web.sh")
  tags = {
    Name = "lms-instance"
  }
}