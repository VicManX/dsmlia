# Semana 03 — SQL y Base de datos para Data Science

## Objetivos

- Comprender cómo se gestionan las bases de datos relacionales con SQL Server y T-SQL.
- Crear y modificar la estructura de tablas, eligiendo tipos de datos adecuados.
- Consultar, filtrar, combinar y resumir información de la base de datos Northwind.
- Organizar consultas complejas mediante procedimientos almacenados, vistas, subconsultas y CTEs.

## Temas

- Creación y administración de bases de datos y tablas.
- Tipos de datos y operaciones de definición de datos.
- Consultas con `SELECT`, filtros con `WHERE` y operadores lógicos (`AND`, `OR`, `NOT`).
- Operadores aritméticos, patrones con `LIKE` y comodines.
- Combinación de tablas con `JOIN`.
- Funciones agregadas, `GROUP BY`, `HAVING` y ordenamiento.
- Procedimientos almacenados, vistas, subconsultas y CTEs.

## Apuntes

- **DDL**: Lenguaje de Definición de Datos - Data Definition Language, es la parte de SQL que se encarga de crear, modificar y eliminar la estructura de los objetos en una base de datos.
- Las consultas permiten recuperar únicamente la información necesaria mediante condiciones, operadores lógicos y filtros por patrones.
- Los `JOIN` relacionan datos de dos o más tablas; por ejemplo, productos con sus proveedores en Northwind.
- Las funciones `COUNT`, `AVG`, `SUM`, `MIN` y `MAX` calculan indicadores sobre conjuntos de filas. Con `GROUP BY` se resumen por categorías y con `HAVING` se filtran los grupos resultantes.
- Una vista es una tabla virtual basada en una consulta: simplifica el acceso a los datos y puede limitar las columnas expuestas.
- Los procedimientos almacenados reúnen sentencias SQL reutilizables y pueden recibir parámetros.
- Las subconsultas y las CTEs ayudan a expresar consultas complejas de forma más clara. En el ejemplo de la sesión, se cuenta la cantidad de pedidos de cada cliente mediante una subconsulta correlacionada.

## Desarrollo

Durante la sesión se realizaron talleres para crear y modificar una tabla de ventas, relacionar `Products` con `Suppliers`, filtrar y agrupar datos de `Employees` y calcular agregados sobre `OrderDetails` en Northwind.

El desarrollo de la tarea asociada se documenta en `assignments/assignment_03/`.

## Dudas o pendientes

- [ ] Repasar los tipos de `JOIN` y determinar cuándo aplicar cada uno.
- [ ] Practicar consultas que combinen filtros, agrupaciones y funciones agregadas.
- [ ] Ejecutar y adaptar los ejemplos de procedimientos almacenados, vistas y CTEs.

## Recursos

- Presentación de la sesión: `S3_PDE_DSMLIA.pdf`.
- Base de datos de práctica: Northwind.

## Tareas relacionadas

- Taller 1: creación de una tabla de ventas.
- Taller 2: modificación de columnas y tablas.
- Taller 3: consultas con `JOIN` entre productos y proveedores.
- Taller 4: filtros, agrupaciones y funciones agregadas.
- Taller 5: introducción a procedimientos almacenados.
