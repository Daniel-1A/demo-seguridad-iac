# Evidencia de remediacion local

Verificacion: 2026-11-23, Checkov 3.4.6 y Python 3.12, Windows.
Antes: 21 fallas Terraform y 2 Dockerfile; despues: 0 fallas, 1 omitido
Terraform, 0 fallas Dockerfile y 0 errores de analisis.
Se corrigieron **22 instancias de hallazgo**; la excepcion no cuenta.
Los conteos corresponden al gate delimitado, no al escaneo global de la tarea.

Comando: `checkov -d . --skip-path ejemplos-politica --framework terraform dockerfile --external-checks-dir politicas -o json`.
Salida antes: codigo 1. Salida despues: codigo 0.

| ID | Recurso | Antes | Cambio | Despues |
|---|---|---|---|---|
| CKV_AWS_382 | `aws_security_group.demo` | FALLA | Salida TCP 443 limitada a red privada | PASA |
| CKV_AWS_24 | `aws_security_group.demo` | FALLA | Retirar ingreso SSH publico; solo PostgreSQL privado | PASA |
| CKV_AWS_25 | `aws_security_group.demo` | FALLA | Retirar ingreso RDP publico; solo PostgreSQL privado | PASA |
| CKV_AWS_3 | `aws_ebs_volume.demo` | FALLA | encrypted=true en EBS | PASA |
| CKV_AWS_189 | `aws_ebs_volume.demo` | FALLA | EBS referencia una clave KMS de cliente | PASA |
| CKV_AWS_133 | `aws_db_instance.demo` | FALLA | Retencion de backups de 7 dias | PASA |
| CKV_AWS_129 | `aws_db_instance.demo` | FALLA | Exportar logs PostgreSQL y upgrade | PASA |
| CKV_AWS_226 | `aws_db_instance.demo` | FALLA | Habilitar actualizaciones menores | PASA |
| CKV_AWS_16 | `aws_db_instance.demo` | FALLA | storage_encrypted=true en RDS | PASA |
| CKV_AWS_118 | `aws_db_instance.demo` | FALLA | Monitoreo mejorado cada 60 segundos y referencia a rol | PASA |
| CKV_AWS_161 | `aws_db_instance.demo` | FALLA | Habilitar autenticacion IAM | PASA |
| CKV_AWS_293 | `aws_db_instance.demo` | FALLA | Habilitar proteccion contra borrado | PASA |
| CKV_AWS_353 | `aws_db_instance.demo` | FALLA | Habilitar Performance Insights | PASA |
| CKV_AWS_157 | `aws_db_instance.demo` | FALLA | Excepcion EXC-001 aprobada; no contar como remediacion | OMITIDO (EXC-001) |
| CKV_AWS_17 | `aws_db_instance.demo` | FALLA | publicly_accessible=false | PASA |
| CKV2_DEMO_1 | `aws_security_group.demo` | FALLA | Agregar tags.Owner | PASA |
| CKV2_DEMO_1 | `aws_ebs_volume.demo` | FALLA | Agregar tags.Owner | PASA |
| CKV2_DEMO_1 | `aws_db_instance.demo` | FALLA | Agregar tags.Owner | PASA |
| CKV2_AWS_30 | `aws_db_instance.demo` | FALLA | Asociar parameter group con logging de consultas | PASA |
| CKV2_AWS_60 | `aws_db_instance.demo` | FALLA | copy_tags_to_snapshot=true | PASA |
| CKV2_AWS_5 | `aws_security_group.demo` | FALLA | Asociar security group a RDS | PASA |
| CKV_DOCKER_8 | `/docker\Dockerfile.USER` | FALLA | Usuario y grupo 10001 sin privilegios root | PASA |
| CKV_DOCKER_2 | `/docker\Dockerfile.` | FALLA | Agregar HEALTHCHECK HTTP local | PASA |

## Evidencia GitHub
- PR inseguro: https://github.com/Daniel-1A/demo-seguridad-iac/pull/1
- El usuario confirmo que lo cerro sin fusionar.
- Captura aportada por el usuario: `evidencias/pr-1-bloqueado.png`.
  Muestra el check requerido rojo y el merge bloqueado.
- Ejecucion inicial con SARIF publicado:
  https://github.com/Daniel-1A/demo-seguridad-iac/actions/runs/45204232767
- URL del PR de remediacion: PENDIENTE.
- Ejecucion de remediacion verde en GitHub: PENDIENTE.

## Limites
No se ejecuto Terraform validate, plan o apply ni se construyo la imagen.
La clave KMS y el rol IAM son referencias didacticas a recursos preexistentes
que no se han provisionado. El resultado comprueba reglas estaticas, no
viabilidad de despliegue. El contenedor HTTP sirve solo como demo.
La aprobacion EXC-001 esta documentada en excepcion-EXC-001.md.

Referencias de configuracion:
- https://registry.terraform.io/providers/hashicorp/aws/5.87.0/docs/resources/db_instance
- https://www.checkov.io/3.Custom%20Policies/YAML%20Custom%20Policies.html
