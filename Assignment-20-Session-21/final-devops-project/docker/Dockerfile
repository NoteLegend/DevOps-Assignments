FROM python:3.12-alpine AS dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt
FROM python:3.12-alpine
WORKDIR /app
COPY --from=dependencies /install /usr/local
COPY application ./application
RUN mkdir /data && chown 10001:10001 /data
ENV APP_HOST=0.0.0.0 DATA_DIR=/data
USER 10001
EXPOSE 8080
CMD ["python", "-u", "application/app.py"]
