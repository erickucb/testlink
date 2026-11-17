# Abrir la práctica de TestLink en otra computadora

Este proyecto es TestLink 1.9.20: PHP + MariaDB/MySQL. Se ejecuta con un
servidor local, por ejemplo XAMPP; abrir index.php como archivo no funciona.
GitHub aloja el código, no ejecuta TestLink ni incluye la base privada.

## Qué necesitas

- Windows con Git y XAMPP (Apache, PHP y MariaDB).
- La instalación de origen usa PHP 8.5.12 y MariaDB 10.11.16. Con otras
  versiones hay que verificar compatibilidad antes de importar.
- Pedir al propietario, por un canal privado, `local-files.tar` y
  `database.sql` del respaldo verificado. No subirlos a GitHub: contienen
  usuarios, credenciales y datos de la práctica.

El respaldo conserva el proyecto, suites, 48 versiones de casos, un plan,
IDs, vínculos y configuración visual. En la copia actual no hay ejecuciones.

## Pasos

1. Clona el repositorio desde una terminal:

   ```powershell
   git clone https://github.com/erickucb/testlink.git
   cd testlink
   ```

2. Para reproducir exactamente la instalación del propietario, extrae el
   archivo privado `local-files.tar` con 7-Zip o `tar` en una carpeta temporal.
   Contiene `testlink` y `testlink-data`. Copia `testlink` a
   `C:\xampp\htdocs\testlink` y `testlink-data` a `C:\xampp\testlink-data`.
   Si esas carpetas ya existen, respáldalas y usa una instalación separada;
   no sobrescribas otro proyecto. El código del respaldo incluye los ajustes
   activos locales que pueden no estar en este repositorio.

3. Inicia **Apache** y **MySQL** desde el panel XAMPP. Abre
   `http://localhost/phpmyadmin`. Crea una base vacía llamada
   `testlink_practica3`, con juego de caracteres `utf8`.

4. Selecciona esa base, entra en **Importar** y selecciona `database.sql`.
   Debe importarse completo, incluidas vistas y `UDFStripHTMLTags`. No ejecutes
   el instalador de TestLink sobre la base restaurada. El volcado conserva
   los DEFINER originales: si aparecen errores de privilegios o de usuario
   inexistente, hay que adaptarlos al administrador local antes de continuar;
   no omitas las vistas ni la función para saltar el error.

5. En phpMyAdmin crea un usuario local exclusivo para esa base, con una
   contraseña nueva y los permisos necesarios sobre ella. Edita
   `C:\xampp\htdocs\testlink\config_db.inc.php` con esos datos:

   ```php
   <?php
   define('DB_TYPE', 'mysql');
   define('DB_HOST', '127.0.0.1:3306');
   define('DB_NAME', 'testlink_practica3');
   define('DB_USER', 'TU_USUARIO_LOCAL');
   define('DB_PASS', 'TU_CONTRASENA_LOCAL');
   define('DB_TABLE_PREFIX', '');
   ```

   Usa el puerto que muestre tu XAMPP: en la instalación de origen es 3307,
   pero en otra computadora puede ser 3306. No uses automáticamente las
   credenciales del propietario. Si XAMPP está en otra ubicación, adapta las
   rutas de logs y adjuntos en `custom_config.inc.php`.

6. Abre **http://localhost/testlink/** e inicia sesión con un usuario de
   TestLink acordado por privado con el propietario. La cuenta de TestLink
   es diferente del usuario MySQL. No publiques ninguna contraseña aquí.

7. Selecciona «Práctica #3 – Todo.ly» y verifica las suites, los 48 casos y el
   plan. Si falta contenido, confirma que importaste la base completa y que
   config_db.inc.php apunta a esa base. No basta con copiar el código.

## Para volver a abrirlo

Inicia Apache y MySQL en XAMPP y visita `http://localhost/testlink/`.
No hace falta repetir la importación. Funciona en la computadora del amigo
aunque la del propietario esté apagada. No es una URL pública de internet.

## Si solo quieres una instalación nueva

Puedes usar el código clonado y seguir el README original de TestLink para
crear una instalación vacía. Eso no recupera la práctica del propietario.

## Actualizaciones

Usa `git pull` para actualizar el repositorio clonado. No actualiza por sí
solo la copia en XAMPP ni la base. Antes de reemplazar archivos en XAMPP,
respalda la base y conserva config_db.inc.php, custom_config.inc.php y los
adjuntos. La base privada se comparte por separado, nunca mediante Git.
