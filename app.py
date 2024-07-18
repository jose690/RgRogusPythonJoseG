# Importa las clases y funciones necesarias de Flask, y otros módulos
from flask import Flask, request, jsonify, render_template
from config import Config
from models import db
import pyodbc

# Crea una instancia de Flask
app = Flask(__name__)
# Configura la aplicación Flask con los parámetros de configuración de la clase Config
app.config.from_object(Config)
# Inicializa la extensión SQLAlchemy con la aplicación Flask
db.init_app(app)

# Define una ruta para la página principal
@app.route('/')
def index():
    # Renderiza la plantilla 'index.html'
    return render_template('index.html')

# Define una ruta para obtener datos de un usuario usando una consulta SQL directa
@app.route('/obtener_datos_sql', methods=['GET'])
def obtener_datos_sql():
    try:
        # Obtiene el valor de 'cedula' de los parámetros de la solicitud
        cedula = request.args.get('cedula').replace('-', '')  # Elimina los guiones
        # Cadena de conexión a la base de datos
        connection_string = 'DRIVER={ODBC Driver 18 for SQL Server};SERVER=201.237.248.149;DATABASE=PracticaUtilidades;UID=pruebas2016;PWD=pruebas2016'
        # Establece una conexión con la base de datos
        conn = pyodbc.connect(connection_string)
        # Crea un cursor para ejecutar la consulta
        cursor = conn.cursor()
        # Ejecuta el procedimiento almacenado 'ObtenerDatosPorCedula_JoseGuzman' con el parámetro 'cedula'
        cursor.execute('EXEC ObtenerDatosPorCedula_JoseGuzman ?', cedula)
        # Obtiene la primera fila del resultado de la consulta
        row = cursor.fetchone()
        if row:
            # Si se encuentra el usuario, devuelve sus datos en formato JSON
            return jsonify(success=True, data={
                'nombre': row.nombre,
                'apellido1': row.apellido1,
                'apellido2': row.apellido2,
                'fechaNacimiento': row.fechaNacimiento
            })
        else:
            # Si no se encuentra el usuario, devuelve un mensaje de error en formato JSON
            return jsonify(success=False, message='Cédula no encontrada.')
    except Exception as e:
        return jsonify(success=False, message=str(e))

# Ejecuta la aplicación Flask en modo depuración si este archivo se ejecuta como el programa principal
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
