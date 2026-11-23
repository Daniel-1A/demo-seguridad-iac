# Demo de seguridad IaC

Practica de analisis estatico de Terraform y Dockerfile con Checkov y GitHub Actions.
No requiere AWS ni despliegues. Los archivos de `infra/` y `docker/` son
INTENCIONALMENTE INSEGUROS: no ejecutar `terraform apply` ni publicar la imagen.

## Estado de la rama de remediacion

Se corrigieron 22 hallazgos y se documento una unica excepcion aprobada
(CKV_AWS_157). El escaneo local termina con codigo 0. Ver
`docs/remediacion.md` y `docs/excepcion-EXC-001.md`.
El PR de remediacion y su evidencia verde en GitHub estan pendientes.
La siguiente seccion conserva las instrucciones de la linea base historica.

## Estado inicial (historico)

Este es el esqueleto y la linea base insegura. El gate debe fallar hasta que
se corrijan los hallazgos. Todavia no hay PR, proteccion de rama, aprobacion
de excepcion ni informe PDF final. Ninguna captura o resultado se inventa.
Ansible no se incluye porque Terraform y Dockerfile cubren los dos tipos exigidos.

## 1. Ejecutar localmente (PowerShell)

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements-iac.txt
New-Item -ItemType Directory -Force reportes
.\.venv\Scripts\checkov.exe -d . --compact
.\.venv\Scripts\checkov.exe -d . --skip-path ejemplos-politica --framework terraform dockerfile --external-checks-dir politicas -o json --output-file-path reportes
$LASTEXITCODE
```

Un codigo 1 significa hallazgos; revisar la salida para distinguirlo de errores.
El primer comando de escaneo cumple la linea base solicitada por el enunciado.
El segundo delimita el alcance del pipeline para obtener conteos comparables.
El escaneo de todo el repo tambien puede incluir workflows y fixtures:
identificarlos por separado, sin mezclarlos con `infra/` y `docker/`.
Conservar el JSON y la salida de consola antes de modificar archivos.
No se despliega nada al ejecutar estos comandos.

## 2. Probar la politica propia

```powershell
.\.venv\Scripts\checkov.exe -d ejemplos-politica/falla --framework terraform --external-checks-dir politicas --check CKV2_DEMO_1 --compact
$LASTEXITCODE # esperado: 1
.\.venv\Scripts\checkov.exe -d ejemplos-politica/pasa --framework terraform --external-checks-dir politicas --check CKV2_DEMO_1 --compact
$LASTEXITCODE # esperado: 0
```

La politica exige `tags.Owner` en los tres tipos de recurso del demo.
Los fixtures estan fuera de las carpetas del gate general para que el caso
negativo no impida dejar la remediacion en verde. Su prueba negativa solo
acepta codigo 1: otros errores no cuentan como una prueba correcta.

## 3. Subir la linea base y configurar GitHub

1. Crear el primer commit con este esqueleto y subirlo a `main` como linea base.
   La ejecucion roja inicial es esperada. Si el remoto usa otro nombre de rama,
   establecer `main` como rama predeterminada y actualizarlo antes de continuar.
2. En Settings > Rules > Rulesets (o Branches), proteger `main`: exigir PR,
   exigir el status check **Escaneo IaC** y evitar bypass para la demostracion.
   Seleccionar el check despues de que haya corrido al menos una vez.
3. Crear una rama `demo/pr-inseguro`, agregar otro ingreso SSH publico
   (por ejemplo un segundo security group) y abrir PR contra `main`.
4. Esperar el check rojo y tomar capturas del hallazgo y del merge bloqueado.
   Cerrar ese PR SIN fusionar.
5. Desde `main`, crear `fix/remediacion-iac`, corregir al menos ocho hallazgos
   de la linea base y hacer un commit por tipo de correccion.
6. Documentar la unica excepcion autorizada, comprobar la politica y abrir
   el segundo PR. Fusionarlo cuando todos los checks esten verdes.

El workflow publica SARIF ANTES del gate; `--soft-fail` solo se usa para
generar el reporte. El gate conserva el codigo de error y no permite
`continue-on-error`. Las versiones fijas facilitan comparar local y CI;
no congelan todas las dependencias transitivas ni garantizan reproducibilidad total.
Se usa Python 3.12 y Checkov 3.4.6; actualizar versiones debe ser deliberado.
Code Scanning se publica en repositorios publicos para PR de este mismo repo.
Siempre se intenta conservar tambien el artifact cuando existe el reporte,
incluidos repositorios privados y PR de forks con permisos restringidos.

## 4. Correcciones sugeridas

Registrar primero los IDs reales que devuelva la version instalada.
Ejemplos de cambios: restringir SSH y RDP a una red privada de administracion;
cifrar EBS y RDS; habilitar backups, proteccion contra borrado, snapshot final,
Multi-AZ y actualizaciones menores de RDS; agregar etiquetas Owner; usar
usuario no root y HEALTHCHECK en Dockerfile. Pueden aparecer controles
adicionales: corregirlos tambien para que el gate completo quede verde.
Un hallazgo se cuenta por control y recurso: no inventar IDs ni contar
varias veces la misma instancia de hallazgo.

## 5. Exactamente una excepcion (fase de remediacion)

No se activa ningun skip en la linea base. Elegir un hallazgo real de bajo
riesgo para este contexto y solicitar aprobacion al docente o responsable.
Dentro del recurso Terraform correspondiente, usar este formato SOLO despues
de completar sus campos y conseguir la aprobacion:

```text
# checkov:skip=ID_REAL:Motivo concreto; aprobacion=REFERENCIA_REAL; vence=AAAA-MM-DD
```

El comentario es una plantilla, no una aprobacion. Copiarlo con campos vacios
no cumple la tarea. Checkov no hace vencer automaticamente un skip: revisar
la fecha antes de cada entrega y retirar o renovar la excepcion.
No usar listas masivas de `--skip-check`.

## 6. Informe y evidencias

Completar `docs/plantilla-informe.md` con los datos de ambos integrantes,
resultados reales, URLs y capturas; exportarlo como `docs/informe.pdf`.
Ambos integrantes deben aportar commits propios. El PDF final se prepara
despues de ejecutar los PR y registrar las evidencias.

## Referencias

- https://www.checkov.io/3.Custom%20Policies/YAML%20Custom%20Policies.html
- https://www.checkov.io/2.Basics/CLI%20Command%20Reference.html
- https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/uploading-a-sarif-file-to-github
- https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches
