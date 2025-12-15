# Use a modern, stable Python version (e.g., 3.11-slim for smaller size)
FROM python:3.11-slim

WORKDIR /app

RUN pip install --upgrade pip

# Install the necessary system dependencies for pyodbc
RUN apt-get update && apt-get install -y unixodbc-dev

COPY app.py requirements.txt /app/

RUN pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "app.py"]
