# Configuración de la aplicación Flask
class Config:
    # Cadena de conexión a la base de datos Microsoft SQL Server utilizando el controlador pyodbc
    SQLALCHEMY_DATABASE_URI = 'mssql+pyodbc://pruebas2016:pruebas2016@201.237.248.149/PracticaUtilidades?driver=ODBC+Driver+18+for+SQL+Server'
    # Desactivar el seguimiento de modificaciones para mejorar el rendimiento
    SQLALCHEMY_TRACK_MODIFICATIONS = False
