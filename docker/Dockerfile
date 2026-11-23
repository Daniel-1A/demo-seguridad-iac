# Demo para analisis estatico; no publicar como servicio de produccion.
FROM python:3.12-slim
WORKDIR /app
RUN groupadd --gid 10001 app \
    && useradd --uid 10001 --gid app --no-create-home app \
    && chown app:app /app
USER 10001:10001
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["python", "-c", "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/', timeout=2).close()"]
CMD ["python", "-m", "http.server", "8000"]
