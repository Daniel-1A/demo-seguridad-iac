# EXC-001: Multi-AZ en demo estatico

- Control: CKV_AWS_157, recurso aws_db_instance.demo.
- Configuracion: multi_az = false; unica excepcion activa de Checkov.
- Aprobador: Daniel-1A, responsable del repositorio.
- Referencia: aprobacion explicita en chat Codex el 2026-11-23:
  "La apruebo como responsable del repositorio".
- Vencimiento: 2026-12-07 (fecha limite; no extender sin nueva aprobacion).
- Justificacion: solo se analiza codigo; no hay despliegue, datos ni usuarios.
  Por tanto, no existe un servicio activo cuya disponibilidad se reduzca.
- Riesgo residual si se desplegara: interrupcion ante fallo de una zona.
- Condicion: no desplegar; retirar el skip y habilitar Multi-AZ antes de
  cualquier uso real. Mantener el resto de los controles activos.
- Responsable de revision: Daniel-1A, antes de la entrega y del vencimiento.
- Checkov no interpreta el vencimiento: su revision es manual.
- Para produccion deberian aprobar el riesgo el propietario del servicio y
  el responsable de seguridad/continuidad; esta aprobacion solo cubre el demo.
