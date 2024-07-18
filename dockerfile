FROM ubuntu:18.04

RUN apt-get update -y && \      
    apt-get install -y \    
    libpq-dev \     
    gcc \
    python3-pip \
    unixodbc-dev

RUN apt-get update && apt-get install -y \
    curl apt-utils apt-transport-https debconf-utils gcc build-essential g++-5\
    && rm -rf /var/lib/apt/lists/*

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y --allow-unauthenticated msodbcsql17

RUN pip3 install pyodbc

WORKDIR /app

COPY requirements.txt requirements.txt


RUN pip3 install -r requirements.txt

COPY . .

CMD ["python3","LoadAPI_data.py"]
