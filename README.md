
# AgroLink Aplicación Flutter
AgroLink es una aplicación móvil basada en Flutter diseñada para gestionar datos agrícolas, incluyendo productos, clientes, ofertas y pedidos. Esta aplicación permite realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) con una interfaz de usuario intuitiva para la entrada de datos (agregar registros) y la visualización de datos.

---

## Tabla de Contenidos
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Modelos](#modelos)
- [Pantallas](#pantallas)
  - [Pantallas de Agricultor](#pantallas-de-agricultor)
  - [Pantallas de Cliente](#pantallas-de-cliente)
  - [Pantallas Generales](#pantallas-generales)
- [Servicios](#servicios)
- [Temas](#temas)
- [Cómo Empezar](#cómo-empezar)

---

## Estructura del Proyecto

Este proyecto está organizado en varios directorios para mejorar la legibilidad y el mantenimiento.

```
lib/
├── config/
│   └── config.dart                # Archivo de configuración para la IP de la API
├── cultivos/
│   └── land.dart                  # Información y funcionalidad relacionada con los cultivos (ya no se usa)
├── models/                        # Modelos que representan los datos de la aplicación
│   └── Agricultor/                # Modelos específicos de datos agrícolas
│       ├── agricultor.dart
│       ├── categoria.dart
│       ├── oferta.dart
│       ├── pedido.dart
│       ├── produccion.dart
│       ├── producto.dart
│       └── terreno.dart
│   ├── cliente.dart               # Modelo de Cliente
│   └── user.dart                  # Modelo de Usuario
├── screen/                        # Contiene todas las pantallas o vistas
│   ├── Agricultor/                # Pantallas relacionadas con datos agrícolas
│   ├── cliente/                   # Pantallas relacionadas con clientes
│   ├── services/                  # Servicios de API y autenticación
│   └── Themes/                    # Configuración de temas
└── main.dart                      # Punto de entrada principal de la aplicación
```

---

## Modelos

Cada modelo representa una entidad en la aplicación e incluye métodos para serializar y deserializar datos entre la aplicación y la API backend.

### Modelos de Agricultor:

- **`agricultor.dart`**: Representa la entidad Agricultor.
- **`categoria.dart`**: Maneja las categorías de productos o terrenos.
- **`oferta.dart`**: Define las ofertas creadas por los agricultores.
- **`pedido.dart`**: Modelo para los pedidos de los clientes, incluyendo detalles de productos.
- **`produccion.dart`**: Representa los detalles de producción para cada producto agrícola.
- **`producto.dart`**: Almacena información de productos.
- **`terreno.dart`**: Modelo para los terrenos gestionados por un agricultor.

### Modelo de Cliente:

- **`cliente.dart`**: Representa los clientes que realizan pedidos.

### Modelo de Usuario:

- **`user.dart`**: Define la estructura de las cuentas de usuario en la aplicación.

> **Nota**: Cada modelo incluye métodos `fromJson` y `toJson` para el análisis y codificación de datos entre la aplicación y la API.

---

## Pantallas

### Pantallas de Agricultor

Estas pantallas manejan varios aspectos de los datos agrícolas, incluyendo agregar, editar y ver diferentes entidades.

#### Pantallas de Agregar:

- **`add_oferta_screen.dart`**: Permite a los usuarios crear una nueva oferta.
- **`add_pedido_screen.dart`**: Pantalla para añadir un nuevo pedido de cliente.
- **`add_produccion_screen.dart`**: Utilizada para agregar detalles de producción.
- **`add_producto_screen.dart`**: Agrega un nuevo producto bajo un agricultor.
- **`add_terreno_screen.dart`**: Añade detalles de terreno relacionados con un agricultor.

#### Pantallas de Visualización:

- **`ofertas_screen.dart`**: Muestra una lista de todas las ofertas creadas por un agricultor.
- **`pedidos_screen.dart`**: Muestra todos los pedidos realizados por clientes.
- **`producciones_screen.dart`**: Lista todos los registros de producción.
- **`producto_screen.dart`**: Pantalla de visualización de todos los productos de un agricultor.
- **`terreno_screen.dart`**: Muestra detalles sobre los registros de terrenos.

> **Nota**: Cada pantalla proporciona una interfaz estructurada para la entrada de datos (usando formularios) y muestra los datos de la API en un formato fácil de usar (listas y expansiones).

### Pantallas de Cliente

Estas pantallas gestionan los datos y funcionalidad relacionados con los clientes.

#### Agregar Cliente:

- **`add_cliente_screen.dart`**: Pantalla para agregar un nuevo cliente al sistema.

#### Ver Clientes:

- **`clientes_screen.dart`**: Muestra una lista de todos los clientes.

### Pantallas Generales

#### Pantalla de Inicio:

- **`home_screen.dart`**: La pantalla principal con navegación a diferentes secciones como agricultor, cliente y pedidos.

#### Pantalla de Sección:

- **`section_screen.dart`**: Sirve como pantalla de navegación secundaria para varias secciones de la aplicación.

### Pantallas de Autenticación

#### Pantalla de Login:

- **`login_screen.dart`**: Pantalla para la funcionalidad de inicio de sesión.

#### Pantalla de Registro:

- **`signup_screen.dart`**: Pantalla para el registro de nuevos usuarios.

---

## Servicios

- **`api_service.dart`**: Contiene funciones para interactuar con la API backend, manejando solicitudes para operaciones CRUD en varias entidades.
- **`auth_service.dart`**: Gestiona las solicitudes de autenticación como inicio de sesión y registro.

---

## Temas

- **`Themes/`**: Contiene configuraciones de temas, como colores, fuentes y estilos de diseño utilizados en toda la aplicación para una interfaz de usuario coherente.

---

## Cómo Empezar

### Requisitos

- Asegúrate de tener Flutter instalado.
- Configura tu API backend como se describe en la documentación de la API.

### Instalación

1. Clona el repositorio:

   ```
   git clone https://github.com/ldgd2/App-Agricultor-Flutter.git
   ```

2. Navega a la carpeta del proyecto:

   ```
   cd AgroLink-main
   ```

3. Instala las dependencias:

   ```
   flutter pub get
   ```

### Ejecutar la Aplicación

1. Conecta tu dispositivo o inicia un emulador.
2. Ejecuta la aplicación con:

   ```
   flutter run
   ```

---

Este README proporciona una visión general de la aplicación AgroLink, detallando su estructura de archivos, modelos, pantallas y cómo empezar con el desarrollo. ¡No dudes en contribuir y mejorar esta aplicación!



Configuración del Proyecto Flutter para Windows

Este proyecto requiere algunos pasos previos en la configuración de la plataforma Windows en Flutter. 
Asegúrate de seguir las instrucciones a continuación antes de ejecutar el programa en un entorno Windows.

Pasos de Configuración

1. Limpieza del Proyecto

   Antes de iniciar, limpia cualquier archivo o configuración anterior del proyecto. Esto garantiza que se utilicen 
   archivos de compilación actualizados. Para limpiar el proyecto, ejecuta:

       flutter clean

2. Actualización de Dependencias

   Una vez limpio el proyecto, asegúrate de instalar todas las dependencias necesarias con:

       flutter pub get

3. Habilitar la plataforma Windows en Flutter

   Asegúrate de que la plataforma Windows esté habilitada en Flutter. Para habilitarla, abre una terminal en el 
   directorio raíz del proyecto y ejecuta:

       flutter config --enable-windows-desktop

4. Recrear el Directorio de Compilación de Windows

   Si observas algún error relacionado con archivos de compilación faltantes o corruptos, como "CMakeLists.txt" o 
   la carpeta "runner", sigue estos pasos:

   - Primero, elimina la carpeta "windows" en el directorio raíz del proyecto.
   - Luego, regenera los archivos ejecutando:
		```bash
       flutter create .

   Esto reinstalará los archivos necesarios en "windows/" y configurará de nuevo los archivos de compilación.

5. Verificar que CMake esté instalado y en el PATH

   Asegúrate de que CMake esté instalado en tu sistema y accesible desde la terminal. Puedes verificar esto ejecutando:

       cmake --version

   Si CMake no está instalado o en el PATH, Flutter no podrá compilar la aplicación para Windows.

6. Correr nuevamente el proyecto

   Una vez que hayas seguido los pasos anteriores, intenta compilar el proyecto con:

       flutter run -d windows

Estos pasos deberían restaurar los archivos de configuración para Windows y resolver los errores de compilación.
