# network acl creation and rules
resource "aws_network_acl" "lms-nacl" {
  vpc_id = aws_vpc.lms--vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "lms-nacl"
  }
}

# associating nacl with subnet
resource "aws_network_acl_association" "lms-nacl-subnet" {
  network_acl_id = aws_network_acl.lms-nacl.id
  subnet_id      = aws_subnet.lms--subnet.id
}

# nsg with rules
resource "aws_security_group" "lms-nsg" {
  name   = "allow_ssh_http"
  vpc_id = aws_vpc.lms--vpc.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}