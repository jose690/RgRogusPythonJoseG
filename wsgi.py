# Importa la instancia 'app' desde el módulo 'app'
from app import app

# Comprueba si este archivo se está ejecutando como el programa principal
if __name__ == "__main__":
    # Ejecuta la aplicación Flask
    app.run()
