resource "aws_vpc" "ecfvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      name = "ecfvpc"
    }
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.ecfvpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.ecfvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-3a"
}

#Afin de permettre a aws_db_subnet_group d'avoir deux subnets prives donc deux AZ uniquement

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.ecfvpc.id
  cidr_block        = "10.0.3.0/24"  # Nouvelle plage CIDR
  availability_zone = "eu-west-3b"  # Différente AZ
}

resource "aws_internet_gateway" "ecfgateway" {
    vpc_id = aws_vpc.ecfvpc.id
}

resource "aws_route_table" "ecfroute" {
    vpc_id = aws_vpc.ecfvpc.id
    tags = {
      name = "ecfroute"
    }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.ecfroute.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ecfgateway.id
}

resource "aws_route_table_association" "association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.ecfroute.id
}