resource "aws_vpc" "demo_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "demo-vpc"
  }
}

resource "aws_subnet" "demo_public_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    name = "demo-public-subnet"
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    name = "demo-internet-gateway"
  }
}

resource "aws_route_table" "demo_route_table" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    name = "demo-route-table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.demo_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demo_igw.id
}

resource "aws_route_table_association" "demo_public_assoc" {
  subnet_id      = aws_subnet.demo_public_subnet.id
  route_table_id = aws_route_table.demo_route_table.id
}

resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "demo security group"
  vpc_id      = aws_vpc.demo_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${data.http.myip.response_body}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "aws_demo_auth" {
  key_name   = "aws_demo_key"
  public_key = file("~/.ssh/aws_demo.pub")
}

resource "aws_instance" "demo_ec2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.demo_server.id
  key_name               = aws_key_pair.aws_demo_auth.id
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  subnet_id              = aws_subnet.demo_public_subnet.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    name = "demo_ec2_instance"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu"
      identityfile = "~/.ssh/aws_demo"
    })
    interpreter = var.host_os == "windows" ? ["powershell", "-command"] : ["bash", "-c"]
  }

}