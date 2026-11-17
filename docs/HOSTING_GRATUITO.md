# Publicación gratuita: diagnóstico y estado

Revisión: 17 de noviembre de 2026. No hay un despliegue público todavía.

## Instalación que se debe migrar

La instalación activa está en `C:/xampp/htdocs/testlink`, separada de este
repositorio. Se debe migrar esa copia, que contiene las correcciones locales,
y su base completa, no reinstalar TestLink ni importar solo los casos XML.

- TestLink 1.9.20 [fixed], esquema 1.9.20.
- PHP CLI 8.5.12; Apache carga el módulo PHP de `C:/xampp/php`.
  Falta comprobar las extensiones del SAPI web en el destino.
- MariaDB 10.11.16, puerto local 3307, base `testlink_practica3`.
- Extensiones CLI presentes: mysqli, pdo_mysql, mbstring, curl, openssl,
  dom, SimpleXML, xml, xmlreader, xmlwriter, fileinfo, iconv y zlib, entre otras.
  GD y ZIP no aparecen en el inventario CLI; revisar su necesidad y habilitarlas
  para las funciones correspondientes en el hosting.
- 77 tablas/vistas, 1 función `UDFStripHTMLTags`; está activada en la configuración.
- 1 proyecto, 48 versiones de casos, 1 plan y 0 filas de ejecuciones.
- Archivos de la aplicación: 6148, aproximadamente 80 MB sin comprimir.

PHP sirve la aplicación y MariaDB conserva los datos. No hay build React/Vite.
Composer y las dependencias incluidas deben validarse con el PHP del destino.
Que el inicio local responda no prueba compatibilidad completa con otro PHP.

## Respaldo privado

En `todo_revision/migration_20261117_060653/`, excluido de Git:

- `database.sql`: volcado completo con vistas, funciones, disparadores y eventos.
- `inventory.json`: conteos y versiones.
- `local-files.tar`: instalación activa y directorio `testlink-data`.
- `sha256.json`: comprobaciones de integridad.
- `restore-verification.json`: restauración SQL de prueba satisfactoria.

La prueba creó una base temporal independiente, importó el volcado, comparó
los conteos de los 77 objetos y ejecutó la función SQL. La base temporal se
eliminó al terminar. No se modificó la base original.
El respaldo contiene secretos: no subirlo al directorio público ni a GitHub.

## Evaluación de proveedores

InfinityFree gratuito no es compatible con una migración íntegra de esta
instalación: no permite funciones almacenadas; TestLink usa una actualmente.
Su soporte también documenta restricciones de vistas. Importar solo tablas
o desactivar la función no equivale a conservar el funcionamiento.
El tamaño del SQL (637522 bytes) no es el bloqueo principal.
La importación se haría por phpMyAdmin; las conexiones MySQL externas están
restringidas. Los límites de archivos publicados son 1 MB para PHP/HTML/JS,
10 kB para .htaccess y 10 MB para otros archivos; cargas PHP de hasta 20 MB.
No se creó cuenta ni se intentó una importación real en InfinityFree.
Además, hay dos archivos JavaScript de depuración en `third_party/ext-js`
que superan 1 MB (`ext-all-debug.js` y `ext-all-debug-w-comments.js`);
una carga íntegra tampoco cumpliría ese límite de archivos.

Fuentes oficiales:
- https://forum.infinityfree.com/t/can-i-create-stored-procedures-and-functions/117696
- https://forum.infinityfree.com/t/unable-to-create-new-routines-procedures-in-mysql/9672
- https://forum.infinityfree.com/t/file-size-and-upload-limits/49308
- https://forum.infinityfree.com/t/connecting-to-mysql-from-an-external-application/49339/1

Render gratuito no ofrece discos persistentes y su PostgreSQL gratuito caduca
tras 30 días; no resuelve por sí solo esta instalación MariaDB con adjuntos.
https://render.com/docs/free

Oracle Always Free permitiría administrar PHP/MariaDB y almacenamiento, pero
requiere tarjeta de verificación. Descartado por preferencia del usuario.
https://www.oracle.com/cloud/free/faq/

La siguiente opción a probar es HelioHost **Johnny**, gratuito, con PHP,
MariaDB y panel Plesk. No se garantiza compatibilidad hasta comprobar permisos
SQL, extensiones, rutas privadas y funcionamiento en la cuenta real.
Sus registros abren a las 00:00 y 12:00 UTC (20:00 y 08:00 en Bolivia).
Los cupos son limitados; la consulta actual de registro devolvió `error=full`.
Tommy requiere donación y Morty es de pago: no elegirlos para este objetivo.

- https://heliohost.org/signup/
- https://wiki.helionet.org/Signing_Up
- https://wiki.helionet.org/MariaDB
- https://wiki.helionet.org/FAQ

Ningún plan gratuito garantiza permanencia absoluta. Hay que cumplir sus
condiciones de actividad y conservar respaldos fuera del proveedor.

## Pasos pendientes cuando exista la cuenta

1. Crear la cuenta Johnny, verificar correo y entrar en Plesk. El usuario debe
   completar el registro; no compartir contraseñas en el chat.
2. Crear una base vacía y ejecutar `deploy/shared-hosting/permissions-check.sql`.
   Comprobar PHP, extensiones y directorios escribibles sin permisos 777.
3. Preparar una copia privada del volcado para el usuario del hosting:
   adaptar los DEFINER de vistas/funciones, sin tocar el respaldo original.
4. Antes de transferir datos, preparar una copia para compartir que sustituya
   las credenciales Todo.ly de los casos por marcadores, conservando IDs y
   relaciones. La copia local y el respaldo íntegro permanecen privados.
5. Transferir la instalación activa por canal cifrado, excluyendo `.git`,
   respaldos, SQL, scripts de mantenimiento, logs, cachés e instalador.
   Importar la base por el panel, nunca colocando el SQL en httpdocs.
6. Completar las plantillas `.example` en el servidor. Guardar logs/adjuntos
   fuera del directorio público con las rutas autorizadas por open_basedir.
7. Configurar certificado HTTPS y redirección en Plesk; cookies de sesión
   Secure/HttpOnly y display_errors desactivado en PHP. Deshabilitar registro
   libre, cambiar credenciales administrativas débiles y crear acceso de
   consulta para docente/compañeros. No compartir el administrador.
8. Probar inicio/cierre de sesión, proyectos, suites, 48 casos, plan, búsquedas,
   recursos estáticos, importación/exportación y adjuntos. Comparar los conteos
   y comprobar que el historial de ejecuciones sigue vacío. Para probar una
   ejecución nueva, utilizar un proyecto de prueba separado.
9. Confirmar que sin sesión no se accede a casos ni archivos privados, que
   HTTPS tiene certificado válido y que se abre desde otra red.
10. Entregar la URL confirmada solamente después de esas verificaciones.

Las plantillas son preparación, no configuración aplicada a XAMPP ni al hosting.
No se envió ningún commit a GitHub ni se modificó el remoto original.
