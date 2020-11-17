
/*
 *  Create a new VPC for use with an IBM Satellite location
 *
 */
resource "aws_vpc" "ibm_satellite_vpc" {
  cidr_block       = "10.10.0.0/16"

  tags = {
    Name = var.satellite_location_name
  }
}

/*
 *  Create a new internet gateway for the VPC
 *
 */
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.ibm_satellite_vpc.id

  tags = {
    Name = "igw-${var.satellite_location_name}"
  }
}

/*
 *  Create a new route table for the VPC
 *
 */
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.ibm_satellite_vpc.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "rt-${var.satellite_location_name}-public"
  }
}

/*
 *  Create a new security group for IBM Cloud Satellite
 *
 */
resource "aws_security_group" "satellite_sg" {
  name        = "ibm-cloud-satellite"
  description = "Security group for IBM Cloud Satellite hosts"
  vpc_id      = aws_vpc.ibm_satellite_vpc.id

  ingress {
    description = "TLS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Satellite tcp ports"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Satellite udp ports"
    from_port   = 30000
    to_port     = 32767
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ibm-cloud-satellite"
  }
}





/*
 *  Create a new subnet in availability zone 1
 *
 */
resource "aws_subnet" "public_subnet_zone_1" {
  vpc_id            = aws_vpc.ibm_satellite_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.satellite_location_name}-zone-1"
  }
}


/*
 *  Add subnet to new route table
 *
 */
resource "aws_route_table_association" "rta_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_zone_1.id
  route_table_id = aws_route_table.route_table.id
}


/*
 *  Create a new subnet in availability zone 2
 *
 */
resource "aws_subnet" "public_subnet_zone_2" {
  vpc_id            = aws_vpc.ibm_satellite_vpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.satellite_location_name}-zone-2"
  }
}

/*
 *  Add subnet to new route table
 *
 */
resource "aws_route_table_association" "rta_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_zone_2.id
  route_table_id = aws_route_table.route_table.id
}



/*
 *  Create a new subnet in availability zone 3
 *
 */
resource "aws_subnet" "public_subnet_zone_3" {
  vpc_id            = aws_vpc.ibm_satellite_vpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = var.availability_zone_3

  tags = {
    Name = "${var.satellite_location_name}-zone-3"
  }
}

/*
 *  Add subnet to new route table
 *
 */
resource "aws_route_table_association" "rta_subnet_3" {
  subnet_id      = aws_subnet.public_subnet_zone_3.id
  route_table_id = aws_route_table.route_table.id
}


