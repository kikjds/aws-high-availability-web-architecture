// Bastion sg
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow ssh traffic to bastion instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "bastion-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_vpc_security_group_ingress_rule" "bastion_sg_ingress_rule" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

// Private instances sg
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Allow private ssh and http connection from bastion"
  vpc_id      = var.vpc_id

  tags = {
    Name = "private-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_vpc_security_group_ingress_rule" "private_sg_ssh_ingress_rule" {
  security_group_id            = aws_security_group.private_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "private_sg_http_ingress_rule" {
  security_group_id            = aws_security_group.private_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id // Potem trzeba zmienic na alba 
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}


// Bastion ec2
resource "aws_instance" "bastion" {
  ami                    = "ami-01ef747f983799d6f"
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = "default"
  tags = {
    Name = "bastion"
  }
}

// Private instances
resource "aws_instance" "private_instances" {
  count                  = length(var.private_subnet_ids)
  instance_type          = "t3.micro"
  ami                    = "ami-01ef747f983799d6f"
  key_name               = "default"
  user_data              = <<-EOF
                            #!/bin/bash
                            apt update
                            apt install nginx -y
                            echo 'Hello world ${count.index + 1}' > /var/www/html/index.nginx-debian.html
                            EOF
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "private-instance-${count.index + 1}"
  }
}
