# Práctica #3 – Todo.ly con TestLink

Guía para abrir en **Windows** la práctica con sus suites, 48 casos y plan de pruebas.
TestLink funciona con PHP y MariaDB/MySQL. Para abrirlo en tu computadora, sigue estos pasos.

## 1. Descarga lo necesario

| Herramienta | Enlace oficial | Para qué sirve |
| --- | --- | --- |
| **XAMPP para Windows** | [Descargar XAMPP](https://www.apachefriends.org/download.html) | Incluye Apache, PHP, MariaDB y phpMyAdmin. No necesitas instalarlos por separado. |
| **Git para Windows** (opcional) | [Descargar Git](https://git-scm.com/downloads/win) | Permite clonar el repositorio. También puedes descargarlo como ZIP. |
| **7-Zip** | [Descargar 7-Zip](https://www.7-zip.org/) | Permite extraer el respaldo `.tar`. |

Instala XAMPP en `C:\xampp`. La instalación de origen utiliza **PHP 8.5.12 y
MariaDB 10.11.16**; elige el paquete XAMPP con esas versiones si está disponible.

## 2. Descarga el proyecto y solicita los datos

En [este repositorio](https://github.com/erickucb/testlink), pulsa **Code → Download ZIP**
y extrae el archivo. Si prefieres Git, abre una terminal y ejecuta:

```powershell
git clone https://github.com/erickucb/testlink.git
```

Pide al propietario estos archivos **por privado**:

- `local-files.tar`: copia de la instalación con los ajustes de la práctica.
- `database.sql`: base de datos con los proyectos, suites, casos y planes.
- Un usuario y contraseña de **TestLink** para iniciar sesión.

**El repositorio contiene el código; los casos y planes están en la base de datos.**
Los respaldos no están en GitHub porque contienen información privada.

## 3. Coloca los archivos en XAMPP

Extrae `local-files.tar` con 7-Zip en una carpeta temporal. Copia sus carpetas así:

| Carpeta extraída | Destino |
| --- | --- |
| `testlink` | `C:\xampp\htdocs\testlink` |
| `testlink-data` | `C:\xampp\testlink-data` |

Para reproducir esta práctica, utiliza la instalación del respaldo: contiene los
ajustes locales del propietario. El código clonado queda como referencia.
Si ya tienes carpetas con esos nombres, respáldalas antes; no sobrescribas otro trabajo.

## 4. Inicia Apache y MySQL

Abre **XAMPP Control Panel** y pulsa **Start** junto a:

- **Apache**: ejecuta TestLink.
- **MySQL**: ejecuta la base de datos MariaDB incluida en XAMPP.

Ambos deben quedar en verde. Después abre [phpMyAdmin](http://localhost/phpmyadmin/).

## 5. Importa la base de datos

1. En phpMyAdmin, pulsa **Nueva** o **Bases de datos**.
2. Crea una base llamada `testlink_practica3`, con cotejamiento `utf8_general_ci`
   (puede aparecer como `utf8mb3_general_ci`).
3. Selecciona esa base en la columna izquierda.
4. Pulsa **Importar → Seleccionar archivo** y elige `database.sql`.
5. Pulsa **Importar** o **Continuar** al final del formulario y espera la confirmación.

No ejecutes el instalador de TestLink sobre esta base. Si la importación muestra
un error de permisos, `DEFINER` o funciones SQL, consulta la
[guía de restauración](docs/ABRIR_PROYECTO_AMIGO.md); no continúes con una importación incompleta.

## 6. Configura la conexión

En phpMyAdmin, entra en **Cuentas de usuarios → Agregar cuenta de usuario**.
Crea un usuario local, por ejemplo `testlink_amigo`, con una contraseña nueva.
Asígnale los privilegios sobre **`testlink_practica3`**, sin permisos globales.

Abre `C:\xampp\htdocs\testlink\config_db.inc.php` con un editor y ajusta estos valores:

```php
<?php
define('DB_TYPE', 'mysql');
define('DB_HOST', '127.0.0.1:3306');
define('DB_NAME', 'testlink_practica3');
define('DB_USER', 'testlink_amigo');
define('DB_PASS', 'ESCRIBE_AQUI_TU_CONTRASENA_MYSQL');
define('DB_TABLE_PREFIX', '');
```

Usa el puerto de MySQL que indique tu panel XAMPP: puede ser **3306** o **3307**.
Guarda el archivo. Esta contraseña es de la base de datos, no la del inicio de sesión de TestLink.
Si instalaste XAMPP fuera de `C:\xampp`, adapta también las rutas de
`custom_config.inc.php` para los directorios `logs` y `upload_area`.

## 7. Abre la práctica

1. Visita **[Abrir TestLink](http://localhost/testlink/)**.
2. Inicia sesión con la cuenta de TestLink que te pase el propietario por privado.
3. Selecciona **Práctica #3 – Todo.ly**.
4. Comprueba las suites, los **48 casos** y el **plan de pruebas**.

Para volver a abrirlo otro día, basta con iniciar **Apache** y **MySQL** y entrar
a ese enlace. No vuelvas a importar la base. La computadora del propietario puede
estar apagada; el sistema se ejecuta en la tuya.

## Si algo no abre

| Problema | Qué revisar |
| --- | --- |
| Apache o MySQL no inicia | Abre **Logs** en XAMPP y revisa si otro programa ocupa el puerto. |
| Aparece «Not Found» | Comprueba que exista `C:\xampp\htdocs\testlink\index.php`. |
| Error de conexión a la base | Revisa usuario, contraseña, nombre de la base y puerto en `config_db.inc.php`. |
| Entra a TestLink, pero no aparecen los casos | Confirma que importaste `database.sql` y seleccionaste el proyecto correcto. |
| Error al escribir logs o adjuntos | Revisa que exista `C:\xampp\testlink-data` y las rutas de `custom_config.inc.php`. |

Los enlaces `localhost` funcionan después de iniciar XAMPP en tu computadora.

[Guía detallada de restauración](docs/ABRIR_PROYECTO_AMIGO.md) ·
[Documentación original de TestLink](README_TESTLINK.md)
