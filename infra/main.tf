# DEMO INTENCIONALMENTE INSEGURO. Solo analisis estatico; no ejecutar apply.
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "demo" {
  name        = "demo-inseguro"
  description = "Ejemplo didactico: acceso administrativo expuesto"
  vpc_id      = "vpc-00000000000000000"

  ingress {
    description = "SSH abierto para demostrar el gate"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RDP abierto para demostrar el gate"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Salida sin restricciones"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ebs_volume" "demo" {
  availability_zone = "us-east-1a"
  size              = 1
  encrypted         = false
}

resource "aws_db_instance" "demo" {
  identifier              = "demo-inseguro"
  allocated_storage       = 20
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  username                = "demo_user"
  manage_master_user_password = true
  publicly_accessible     = true
  storage_encrypted       = false
  backup_retention_period = 0
  deletion_protection     = false
  skip_final_snapshot     = true
  multi_az                = false
  auto_minor_version_upgrade = false
  copy_tags_to_snapshot   = false
}
