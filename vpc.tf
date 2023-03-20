# vpc
resource "aws_vpc" "lms--vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lms"
  }
}

# subnet -- with enabling public-ip
resource "aws_subnet" "lms--subnet" {
  vpc_id                  = aws_vpc.lms--vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "lms-subnet"
  }
}
