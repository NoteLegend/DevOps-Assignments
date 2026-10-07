FROM python:3.12-alpine
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY application ./application
USER 10001
EXPOSE 5000
CMD ["python", "-m", "flask", "--app", "application.app", "run", "--host=0.0.0.0"]
