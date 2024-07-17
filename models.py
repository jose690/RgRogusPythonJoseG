# Importa la extensión SQLAlchemy de Flask para manejar las interacciones con la base de datos
from flask_sqlalchemy import SQLAlchemy

# Crea una instancia de SQLAlchemy
db = SQLAlchemy()

# Define la clase Usuario que representa la tabla 'TSE' en la base de datos
class Usuario(db.Model):
    # Nombre de la tabla en la base de datos
    __tablename__ = 'TSE'
    
    # Define las columnas de la tabla
    # Columna 'cedula' de tipo String con un máximo de 10 caracteres y es la clave primaria
    cedula = db.Column(db.String(10), primary_key=True)
    
    # Columna 'nombre' de tipo String con un máximo de 40 caracteres
    nombre = db.Column(db.String(40))
    
    # Columna 'apellido1' de tipo String con un máximo de 25 caracteres
    apellido1 = db.Column(db.String(25))
    
    # Columna 'apellido2' de tipo String con un máximo de 25 caracteres
    apellido2 = db.Column(db.String(25))
    
    # Columna 'fechaNacimiento' de tipo String con un máximo de 12 caracteres
    fechaNacimiento = db.Column(db.String(12))
