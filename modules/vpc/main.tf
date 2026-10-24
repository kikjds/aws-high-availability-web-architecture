data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true

  tags = {
    Name = "Main-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main-igw-${aws_vpc.main.id}"
  }

}

// Public Subents 
resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_range_public_azs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public subnet-${count.index + 1}"
  }
}

// Private subnets
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_range_private_azs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "Private subnet-${count.index + 1}"
  }
}

// Nat
resource "aws_eip" "elastic_ip" {
  domain = "vpc"

  depends_on = [aws_vpc.main]
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.elastic_ip.id

  depends_on = [aws_internet_gateway.igw]
}

// Route tables
resource "aws_route_table" "route_tables" {
  count  = 2
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = count.index == 0 ? aws_internet_gateway.igw.id : null
    nat_gateway_id = count.index == 1 ? aws_nat_gateway.nat.id : null
  }

  tags = {
    Name = count.index == 0 ? "public route table" : "private route table"
  }
}

resource "aws_route_table_association" "public_route_tables_association" {
  count          = 3
  route_table_id = aws_route_table.route_tables[0].id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_route_table_association" "private_route_tables_association" {
  count          = 3
  route_table_id = aws_route_table.route_tables[1].id
  subnet_id      = aws_subnet.private[count.index].id
}