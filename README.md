# DSMLIA

Repositorio de trabajo para el curso de DSMLIA. Reúne las sesiones de clase,
los apuntes, las tareas, los datos y el código reutilizable del curso.

## Acceso rápido

- [Información del curso](course/)
- [Sesiones y apuntes](sessions/)
- [Tareas](assignments/)
- [Datos](data/)
- [Guías de ayuda](help/)

## Seguimiento del curso

| Semana | Tema | Sesión | Tarea | Estado |
|-------:|------|--------|-------|--------|
| 01 | Por definir | — | — | Pendiente |

Estados sugeridos: `Pendiente`, `En curso` y `Completado`.

## Estructura

```text
dsmlia/
├── course/      # Programa, cronograma y referencias generales
├── sessions/    # Material y apuntes organizados por semana
├── assignments/ # Una carpeta autocontenida por cada entrega
├── data/        # Datos originales, procesados y muestras pequeñas
├── help/        # Guías de trabajo y referencia
├── src/         # Código reutilizable entre sesiones y tareas
└── tests/       # Pruebas para el código reutilizable
```

Las carpetas de cada semana y tarea se crean solo cuando sean necesarias. En
`sessions/_template/` y `assignments/_template/` hay una base para iniciarlas.

## Convenciones

- Usar nombres en minúsculas, sin espacios ni tildes.
- Numerar con cero inicial: `week_01`, `assignment_01`.
- Usar `main.ipynb` como notebook principal de cada semana o tarea.
- Crear notebooks adicionales solo cuando el trabajo realmente lo requiera.
- Conservar los datos originales sin modificaciones en `data/raw/`.
- Llevar a `src/` solo el código que sea realmente reutilizable.
- No guardar credenciales, archivos `.env`, entornos virtuales ni datos grandes
  en Git.

## Flujo semanal

1. Copiar `sessions/_template/` como `sessions/week_XX/`.
2. Registrar el tema y los apuntes de la semana en su `README.md`.
3. Desarrollar los ejemplos y prácticas de la semana en `main.ipynb`.
4. Si hay una entrega, copiar `assignments/_template/` como
   `assignments/assignment_XX_name/`.
5. Actualizar la tabla de seguimiento de este archivo.
