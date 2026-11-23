# Demostracion didactica: NO desplegar. Cerrar el PR sin fusionar.
resource "aws_security_group" "ssh_publico_pr" {
  name        = "demo-pr-ssh-publico"
  description = "Cambio inseguro intencional para comprobar el gate"
  vpc_id      = "vpc-00000000000000000"

  ingress {
    description = "SSH expuesto a Internet: debe bloquearse"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner = "equipo-seguridad-iac"
  }
}
