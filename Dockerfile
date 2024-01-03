# Usar una imagen base de Python compatible con la arquitectura ARM
FROM arm64v8/python:3.9-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Instalar dependencias necesarias para Chromium
RUN apt-get update && apt-get install -y wget gnupg2 software-properties-common \
    && apt-get install -y chromium \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Descargar y configurar Chromedriver compatible con ARM
# Asegúrate de reemplazar la URL con la dirección del Chromedriver correcto para ARM
RUN wget -q "url_del_chromedriver_para_arm" -O /tmp/chromedriver.zip \
    && unzip /tmp/chromedriver.zip -d /tmp \
    && mv /tmp/chromedriver /app/build/ \
    && chmod +x /app/build/chromedriver \
    && rm /tmp/chromedriver.zip

# Configurar la variable de entorno para que el sistema encuentre el Chromedriver
ENV CHROMEDRIVER_PATH /app/build/chromedriver
ENV CHROME_BIN /usr/bin/chromium

# Copiar el archivo de requisitos primero para aprovechar la caché de Docker
COPY requirements.txt /app/

# Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto de los archivos del proyecto al contenedor
COPY . /app

# El comando que se ejecuta cuando se inicia el contenedor
CMD ["python", "main.py"]
