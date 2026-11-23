# Verificacion local del esqueleto

Fecha: 2026-11-23. Python 3.12, Checkov 3.4.6; analisis en Windows.
Se verifico una copia de los archivos y se compararon sus hashes con el repo.

| Alcance | Pasan | Fallan | Omitidos | Errores de analisis |
|---|---|---|---|---|
| Terraform | 9 | 21 | 0 | 0 |
| Dockerfile | 5 | 2 | 0 | 0 |

Comando del gate: `checkov -d . --skip-path ejemplos-politica --framework terraform dockerfile --external-checks-dir politicas -o json`.
Codigo de salida: 1, esperado por las configuraciones inseguras.

Politica CKV2_DEMO_1: caso falla=1; caso pasa=0. SARIF generado con
`-o sarif --output-file-path reportes --soft-fail`, codigo 0; archivo
results_sarif.sarif parseado y version 2.1.0 confirmada.
El YAML del workflow se pudo parsear. No se ejecuto GitHub Actions.

Ejemplos de hallazgos confirmados: CKV_AWS_24 (SSH), CKV_AWS_25 (RDP),
CKV_AWS_3 (cifrado EBS), CKV_AWS_16 (cifrado RDS), CKV_AWS_17
(RDS publico), CKV_DOCKER_8 (usuario root) y CKV_DOCKER_2 (HEALTHCHECK).

Estos resultados son una comprobacion tecnica del esqueleto; no reemplazan
la linea base ejecutada y documentada por los integrantes ni las capturas
de PR, proteccion de rama, publicacion SARIF y remediacion.
Se usa una sola raiz porque con varios argumentos -d esta version produjo
conteos repetidos durante la prueba. Los fixtures se excluyen del gate general.
