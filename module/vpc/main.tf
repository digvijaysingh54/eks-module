data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count           = var.subnet_count
  vpc_id          = aws_vpc.vpc.id
  cidr_block      = "${var.cidr_subnet}.${count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))
  tags = {
    Name = "public-subnet-${count.index}"
  }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.cidr_route
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = var.route_tb_name
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count         = 2
  subnet_id     = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
