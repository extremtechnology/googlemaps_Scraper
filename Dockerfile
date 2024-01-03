# Usar una imagen base de Python compatible con la arquitectura ARM64
FROM arm64v8/python:3.9-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el archivo de requisitos primero para aprovechar la caché de Docker
COPY requirements.txt /app/

# Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Agregar las direcciones de los repositorios y actualizar los paquetes
RUN apt-get update && apt-get install -y wget gnupg2

# Descargar e instalar Chromium y Chromedriver para ARM64
RUN wget http://launchpadlibrarian.net/660838578/chromium-chromedriver_112.0.5615.49-0ubuntu0.18.04.1_arm64.deb
RUN dpkg -i chromium-chromedriver_112.0.5615.49-0ubuntu0.18.04.1_arm64.deb || apt-get install -yf

# Configurar la variable de entorno para que el sistema encuentre el Chromedriver
ENV PATH="/usr/lib/chromium-browser/:$PATH"

# Copiar el resto de los archivos del proyecto al contenedor
COPY . /app

# El comando que se ejecuta cuando se inicia el contenedor
CMD ["python", "main.py"]
