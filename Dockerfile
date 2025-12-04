FROM python:3.9-slim AS base

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM base AS test
COPY . .
WORKDIR /app
CMD ["python", "-m", "pytest", "tests"]

FROM base AS prod
COPY /app .
WORKDIR /app
ENV PORT=8080
EXPOSE 8080

CMD ["python", "app.py"]
