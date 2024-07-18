# Usa una imagen base oficial de Python
FROM python:3.9.2-slim-buster

# Establece el directorio de trabajo
WORKDIR /app

# Instala las dependencias del sistema necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    apt-transport-https \
    gnupg \
    unixodbc-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    gcc \
    g++ \
    unixodbc \
    libpq-dev \
    && apt-get clean

# Añade la clave GPG de Microsoft
RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc

# Añade el repositorio de Microsoft para el ODBC Driver 18
RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | tee /etc/apt/sources.list.d/mssql-release.list

# Instala el ODBC Driver 17 para SQL Server
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 && ACCEPT_EULA=Y apt-get install -y mssql-tools18

# Instala unixodbc para asegurarse de que el controlador ODBC funcione
RUN apt-get install -y unixodbc

# Copia los archivos de tu aplicación al contenedor
COPY . /app

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto en el que la aplicación correrá
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]
