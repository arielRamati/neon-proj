FROM python:3.9-slim

WORKDIR /app

COPY . .
RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONPATH=/app

ENV PORT=8080
EXPOSE 8080

CMD ["python", "app/app.py"]
