# Usar una imagen base de Python compatible con la arquitectura ARM64
FROM arm64v8/python:3.9-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Instalar las dependencias necesarias para Google Chrome y Chromedriver
RUN apt-get update && apt-get install -y wget gnupg2 software-properties-common

# Descargar e instalar Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# Instalar Chromium y Chromedriver para ARM64 (si aún no lo has hecho)
RUN wget http://launchpadlibrarian.net/660838578/chromium-chromedriver_112.0.5615.49-0ubuntu0.18.04.1_arm64.deb
RUN dpkg -i chromium-chromedriver_112.0.5615.49-0ubuntu0.18.04.1_arm64.deb || apt-get -fy install

# Configurar la variable de entorno para que el sistema encuentre el Chromedriver
ENV PATH="/usr/lib/chromium-browser/:$PATH"

# Copiar el resto de los archivos del proyecto al contenedor
COPY . /app

# Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# El comando que se ejecuta cuando se inicia el contenedor
CMD ["python", "main.py"]
