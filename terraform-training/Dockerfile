FROM python:3.11-slim

WORKDIR /app
RUN pip install --upgrade pip

COPY app.py requirements.txt /app/
RUN pip install -r requirements.txt

EXPOSE 8080
CMD ["python", "app.py"]
