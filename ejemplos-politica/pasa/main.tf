# Fixture aislado: escanear solo CKV2_DEMO_1.
resource "aws_ebs_volume" "ejemplo" {
  availability_zone = "us-east-1a"
  size              = 1
  encrypted         = true
  tags = {
    Owner = "equipo-seguridad-iac"
  }
}
