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

# Red privada ilustrativa; no desplegar este demo.
resource "aws_security_group" "demo" {
  name        = "demo-restringido"
  description = "PostgreSQL accesible solo desde la red privada de aplicacion"
  vpc_id      = "vpc-00000000000000000"

  ingress {
    description = "PostgreSQL desde la aplicacion"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.10.0/24"]
  }

  egress {
    description = "HTTPS solo a la red privada de servicios"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Owner = "equipo-seguridad-iac"
  }
}

resource "aws_ebs_volume" "demo" {
  availability_zone = "us-east-1a"
  size              = 1
  encrypted         = true
  kms_key_id        = data.aws_kms_key.demo.arn
  tags = {
    Owner = "equipo-seguridad-iac"
  }
}

resource "aws_db_instance" "demo" {
  identifier              = "demo-inseguro"
  allocated_storage       = 20
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  username                = "demo_user"
  manage_master_user_password = true
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.demo.id]
  storage_encrypted       = false
  backup_retention_period = 0
  deletion_protection     = false
  skip_final_snapshot     = true
  multi_az                = false
  auto_minor_version_upgrade = false
  copy_tags_to_snapshot   = false
}

# Referencias didacticas a recursos preexistentes: no son credenciales.
# Un despliegue real requiere provisionar la clave y el rol con permisos correctos.
data "aws_kms_key" "demo" {
  key_id = "alias/demo-seguridad-iac"
}

data "aws_iam_role" "rds_monitoring" {
  name = "demo-rds-enhanced-monitoring"
}
