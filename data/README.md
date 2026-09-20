# Datos

Los datos se separan segun su etapa:

- `raw/`: archivos originales, sin modificaciones.
- `processed/`: resultados de limpieza o transformación.
- `sample/`: muestras pequeñas que sí pueden versionarse en Git.

Los contenidos de `raw/` y `processed/` están ignorados por Git para evitar
subir archivos grandes o generados. Cada dataset debe documentar, al menos, su
origen, fecha de descarga, licencia y el proceso necesario para reproducirlo.

No almacenar aquí credenciales, datos personales o información sensible.
