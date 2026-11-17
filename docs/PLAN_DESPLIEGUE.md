# Despliegue del TestLink actual

## Diagnóstico

Este repositorio contiene TestLink: backend PHP, plantillas Smarty, recursos
HTML/CSS/JavaScript y base de datos MySQL. Composer gestiona las dependencias PHP.
package.json incluye tablednd pero no contiene scripts de build o arranque.
No es una aplicación React/Vite ni genera una carpeta dist publicable.

Netlify ofrece PHP en su entorno de construcción, pero no un servidor PHP
persistente para atender las páginas de TestLink. Tampoco sustituye la base
MySQL, las sesiones ni el almacenamiento persistente. Publicar la raíz como
archivos estáticos no entrega el sistema funcional y puede exponer código.
No se ha creado netlify.toml ni se ha realizado un despliegue incompatible.

Referencias:
- https://docs.netlify.com/build/configure-builds/manage-dependencies/
- https://answers.netlify.com/t/how-can-i-use-php/84186/3

## Plan para una URL que funcione con la computadora apagada

1. Elegir un hosting PHP con MySQL o un servidor con contenedores y volúmenes
   persistentes. Confirmar proveedor, cuenta y costo antes de aprovisionar.
2. Validar la versión PHP y extensiones contra esta versión de TestLink y sus
   dependencias. El Dockerfile existente usa PHP 7.4: no desplegarlo sin revisar
   soporte, seguridad y compatibilidad. El compose actual es de desarrollo.
3. Preparar un repositorio privado y revisar todo el contenido antes del push.
   Conservar el remoto del proyecto original; configurar el repositorio personal
   por separado después de verificar destino, acceso y privacidad.
4. Crear credenciales de producción fuera de Git. Configurar conexión MySQL,
   URL HTTPS, sesiones, logs y almacenamiento persistente de adjuntos.
5. Respaldar y migrar la base de datos y los adjuntos por un canal privado.
   Los casos están en MySQL: subir solamente el código no los migra.
6. Antes de compartir, decidir si usar una copia sin credenciales Todo.ly y crear
   un usuario de consulta para el destinatario. No compartir la cuenta admin.
7. Comprobar login, 48 casos, suites, pasos, plan, resultados históricos,
   recursos estáticos y exportación. Verificar desde otra computadora.
8. Entregar únicamente la URL real confirmada por el proveedor.

## Comandos identificados

- Dependencias PHP reproducibles: `composer install --no-dev --prefer-dist`
  (usar composer.lock; validar plataforma y extensiones primero).
- Dependencia JavaScript: `yarn install --frozen-lockfile` (existe yarn.lock).
- Desarrollo con contenedores: `docker compose up -d --build`.
- No hay comando npm build ni carpeta de publicación estática.

Estos comandos se documentan; no se han instalado dependencias ni desplegado
contenedores de producción durante esta revisión.

## Actualizaciones posteriores

Revisar los cambios, ejecutar las verificaciones correspondientes, crear un
commit y hacer push al repositorio privado del hosting elegido. Desplegar con
su pipeline o procedimiento de servidor; respaldar la base antes de migraciones
y conservar una versión anterior para revertir. La URL estable depende del
hosting, no de mantener abierto VS Code o XAMPP.

## Archivos privados

Se excluyen configuraciones locales, variables de entorno, logs, respaldos y
scripts de mantenimiento con datos privados. .gitignore evita agregar archivos
nuevos; no elimina secretos de archivos ya versionados ni del historial.
Es necesaria una revisión adicional antes de enviar el repositorio remoto.
