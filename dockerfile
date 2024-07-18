# Usa una imagen base oficial de Python
FROM python:3.9.2-slim-buster

# Establece el directorio de trabajo
WORKDIR /app

# Instala las dependencias del sistema necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    apt-transport-https \
    gnupg \
    unixodbc \
    unixodbc-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    gcc \
    g++ \
    libpq-dev \
    && apt-get clean

# Añade la clave GPG de Microsoft
RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc

# Añade el repositorio de Microsoft para el ODBC Driver 18
RUN curl https://packages.microsoft.com/config/debian/10/prod.list | tee /etc/apt/sources.list.d/mssql-release.list

# Instala el ODBC Driver 18 para SQL Server
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18

# Establece las variables de entorno necesarias
ENV PATH=/opt/mssql-tools18/bin:$PATH

# Copia los archivos de tu aplicación al contenedor
COPY . /app

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto en el que la aplicación correrá
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]
