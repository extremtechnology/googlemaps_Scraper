# Usar una imagen base de Python compatible con la arquitectura ARM
FROM arm64v8/python:3.9-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Instalar dependencias necesarias para Chromium y Chromedriver
RUN apt-get update && apt-get install -y wget gnupg2 software-properties-common \
    && apt-get install -y chromium chromium-driver \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configurar la variable de entorno para que el sistema encuentre el Chromedriver
ENV CHROMEDRIVER_PATH /usr/bin/chromedriver
ENV CHROME_BIN /usr/bin/chromium

# Copiar el archivo de requisitos primero para aprovechar la caché de Docker
COPY requirements.txt /app/

# Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto de los archivos del proyecto al contenedor
COPY . /app

# El comando que se ejecuta cuando se inicia el contenedor
CMD ["python", "main.py"]
