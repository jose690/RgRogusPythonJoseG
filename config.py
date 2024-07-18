import os

class Config:
    # Configuración general
    DEBUG = True
    TESTING = False
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'default_secret_key'

    # Configuración de la base de datos
    DB_DRIVER = 'ODBC Driver 18 for SQL Server'
    DB_SERVER = os.environ.get('DB_SERVER') or '201.237.248.149'
    DB_NAME = os.environ.get('DB_NAME') or 'PracticaUtilidades'
    DB_USER = os.environ.get('DB_USER') or 'pruebas2016'
    DB_PASSWORD = os.environ.get('DB_PASSWORD') or 'pruebas2016'
    
    # Construcción de la cadena de conexión
    SQLALCHEMY_DATABASE_URI = (
        f"mssql+pyodbc://{DB_USER}:{DB_PASSWORD}@{DB_SERVER}/{DB_NAME}"
        f"?driver={DB_DRIVER}"
    )

    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Otras configuraciones
    ITEMS_PER_PAGE = 10
