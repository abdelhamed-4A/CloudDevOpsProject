resource "aws_vpc" "ivolve_vpc" {
  cidr_block = "10.0.0.0/16"  # Recommended CIDR for new VPCs
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "ivolve-tf"  # Must match the tag in your data source
  }
}

data "aws_vpc" "selected" {
  depends_on = [aws_vpc.ivolve_vpc]  # Explicit dependency
  filter {
    name   = "tag:Name"
    values = ["ivolve-tf"] 
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "PublicRouteTable"
  }
}
resource "aws_route" "internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}