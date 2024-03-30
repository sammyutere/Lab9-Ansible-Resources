locals {
  name = "sutere-ansible-demo"
}

resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${local.name}-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = var.az1
  tags = {
    Name = "${local.name}-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.name}-igw"
  }
}


resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id   
  }

}

resource "aws_route_table_association" "route-table-assoc" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.route-table.id
}


resource "aws_security_group" "security-group1" {
  name        = "ansible-sg"
  description = "ansible_security_group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "${local.name}-ansible-sg"
  }
}

resource "aws_security_group" "security-group2" {
  name        = "instance-sg"
  description = "instance_security_group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from vpc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "${local.name}-instance-sg"
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "ansible-lab"
  public_key = file(var.path_to_keypair)

}

resource "aws_instance" "ansible" {
  ami                         = var.ubuntu
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-subnet.id
  key_name                    = aws_key_pair.keypair.id
  vpc_security_group_ids      = [aws_security_group.security-group1.id]
  user_data                   = file("./userdata.sh")

  tags = {
    Name = "${local.name}-ansible"
  }

}

resource "aws_instance" "redhat" {
  ami                         = var.red-hat
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-subnet.id
  key_name                    = aws_key_pair.keypair.id
  vpc_security_group_ids      = [aws_security_group.security-group2.id]
  tags = {
    Name = "${local.name}-redhat"
  }
}

resource "aws_instance" "ubuntu" {
  ami                         = var.ubuntu
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-subnet.id
  key_name                    = aws_key_pair.keypair.id
  vpc_security_group_ids      = [aws_security_group.security-group2.id]
  tags = {
    Name = "${local.name}-ubuntu"
  }
}






