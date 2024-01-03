# Usar una imagen base de Python compatible con Selenium
FROM python:3.9-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el archivo de requisitos primero para aprovechar la caché de Docker
COPY requirements.txt /app/

# Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Instalar Chromium y Chromedriver
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Copiar el resto de los archivos del proyecto al contenedor
COPY . /app

# Configurar la variable de entorno para Selenium y Chromedriver
ENV CHROMEDRIVER_PATH /usr/bin/chromedriver
ENV CHROMEDRIVER_PORT 9515

# El comando que se ejecuta cuando se inicia el contenedor
CMD ["python", "main.py"]
