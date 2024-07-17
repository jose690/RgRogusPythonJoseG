# Usa una imagen base oficial de Python
FROM python:3.8-slim

# Establece el directorio de trabajo
WORKDIR /app

# Instala las dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    gnupg \
    unixodbc-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    gcc \
    && apt-get clean

# Añade la clave GPG de Microsoft
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Añade el repositorio de Microsoft para el ODBC Driver 17
RUN curl https://packages.microsoft.com/config/debian/10/prod.list | tee /etc/apt/sources.list.d/mssql-release.list

# Instala el ODBC Driver 17 para SQL Server
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

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
