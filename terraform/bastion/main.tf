resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access from anywhere"
  vpc_id      = var.vpc_id

  ingress {
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

  tags = { Name = "Bastion Security Group" }
}

resource "aws_instance" "bastion" {
  ami                   = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.public_subnet_id
  key_name              = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  tags = { Name = "Bastion-EC2-Instance" }
}
