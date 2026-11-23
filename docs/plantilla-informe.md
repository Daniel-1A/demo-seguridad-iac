# Analisis de seguridad IaC en el pipeline

PLANTILLA PENDIENTE: no representa una entrega terminada.

## 1. Portada
Integrantes: PENDIENTE. Curso y fecha: PENDIENTE. Repositorio: PENDIENTE.

## 2. Linea base local
Registrar fecha, version de Python y Checkov, comandos, codigo de salida y
conteos por tipo de archivo. Adjuntar salida original. Separar el escaneo
global del alcance Terraform/Docker del pipeline.

| Tipo | Pasan | Fallan | Omitidos | Errores de analisis |
|---|---|---|---|---|
| Terraform | pendiente | pendiente | pendiente | pendiente |
| Dockerfile | pendiente | pendiente | pendiente | pendiente |

| ID real | Recurso | Riesgo real y condiciones necesarias para explotarlo |
|---|---|---|
| pendiente 1 | | |
| pendiente 2 | | |
| pendiente 3 | | |
| pendiente 4 | | |
| pendiente 5 | | |

## 3. Diseno del pipeline
Explicar eventos, carpetas, versiones fijas, publicacion SARIF previa al gate,
codigo de salida, politica propia y proteccion de main.

## 4. Evidencia del gate
URL del PR inseguro cerrado sin fusionar: PENDIENTE.
Capturas del check rojo, regla de proteccion y boton de merge bloqueado: PENDIENTE.

## 5. Evidencia SARIF
URL de ejecucion y captura de Security > Code scanning o artifact: PENDIENTE.

## 6. Remediacion
URL del PR fusionado y ejecucion verde: PENDIENTE.
Agregar ocho o mas filas, una por hallazgo real remediado.

| ID | Recurso | Antes | Cambio aplicado | Resultado despues | Commit |
|---|---|---|---|---|---|
| pendiente | | | | | |

## 7. Excepcion unica
Codigo del skip: PENDIENTE. Riesgo residual: PENDIENTE.
Justificacion y controles compensatorios: PENDIENTE.
Aprobador, referencia verificable y fecha de vencimiento: PENDIENTE.
Explicar quien revisara el vencimiento: Checkov no lo impone automaticamente.

## 8. Politica propia
Incluir YAML de politicas/etiquetas-obligatorias.yaml y salidas reales:
caso falla (codigo 1), caso pasa (codigo 0).
Explicar que Owner facilita asignar responsables, pero no verifica su identidad.

## 9. Conclusiones
Explicar limites: analisis estatico no demuestra la configuracion desplegada,
permisos efectivos ni seguridad de paquetes de la imagen. Proponer revision
de permisos, deteccion de drift y escaneo de imagenes como controles adicionales.

## Declaracion de uso de IA
Se utilizo IA para proponer el esqueleto, los ejemplos didacticos, el workflow
y esta plantilla. Los integrantes deben describir que revisaron y ejecutaron.
Las capturas, aprobaciones, PR y resultados deben provenir de su trabajo real.
