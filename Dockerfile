# Usar selenium/standalone-chrome como imagen base
FROM selenium/standalone-chrome:latest

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el archivo de requisitos de Python (si es necesario)
# Asegúrate de que requirements.txt contenga todas las dependencias de Python necesarias
COPY requirements.txt /app/

# Instalar las dependencias de Python desde el archivo requirements.txt
# Solo es necesario si tu proyecto Python tiene dependencias adicionales
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install --no-cache-dir -r requirements.txt

# Copiar el resto de los archivos de tu aplicación o scripts al contenedor
COPY . /app

# Configurar el comando para ejecutar tu aplicación
# Ajusta este comando según sea necesario para iniciar tu aplicación
CMD ["python3", "main.py"]
