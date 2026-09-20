# Ejecutar Northwind con DBeaver y SQL Server

Esta guía explica cómo ejecutar el script `Northwind.sql` usando DBeaver como
interfaz gráfica y SQL Server como motor de base de datos.

## Idea principal

DBeaver es un cliente de bases de datos: permite administrar conexiones,
escribir consultas y ejecutar scripts, pero no reemplaza al motor SQL Server.

Para ejecutar este script se necesitan dos componentes:

1. una instancia de SQL Server local, remota o en un contenedor;
2. DBeaver conectado a esa instancia.

DBeaver puede reemplazar a SQL Server Management Studio como herramienta
gráfica. No puede, por sí solo, ejecutar un script de SQL Server sin tener un
motor al cual conectarse.

## Por qué el script necesita SQL Server

El archivo utiliza características específicas de T-SQL, entre ellas:

- `USE master` y `CREATE DATABASE`;
- separadores de lotes `GO`;
- catálogos internos como `sysdatabases`;
- columnas `IDENTITY`;
- tipos `money`, `image`, `ntext` y `bit`;
- `SET IDENTITY_INSERT`;
- vistas y procedimientos almacenados.

Por estas razones no se puede ejecutar directamente en SQLite, DuckDB u otro
motor embebido mediante un simple cambio de conexión.

> **Advertencia:** el script elimina cualquier base existente llamada
> `Northwind` antes de crearla nuevamente. No debe ejecutarse si esa base
> contiene información que se necesite conservar.

## 1. Disponer de una instancia de SQL Server

Se puede utilizar una de estas opciones:

- una instancia proporcionada por el docente o la institución;
- SQL Server Developer o Express instalado localmente;
- SQL Server ejecutándose en un contenedor Docker.

Para un entorno de aprendizaje se recomienda una instancia local o un
contenedor dedicado, sin información importante.

Si se usa Docker, Microsoft publica imágenes oficiales de SQL Server. El
contenedor debe exponer un puerto, normalmente `1433`, para que DBeaver pueda
conectarse. También debe utilizar un volumen persistente si se quiere conservar
la base después de reemplazar el contenedor.

## 2. Crear la conexión en DBeaver

En DBeaver:

1. Seleccionar **Database → New Database Connection**.
2. Buscar y seleccionar **SQL Server**.
3. Permitir la descarga del controlador JDBC cuando DBeaver la solicite.
4. Completar los datos de conexión.

Para una instalación local con valores estándar:

```text
Host:           localhost
Port:           1433
Database:       master
Authentication: SQL Server Authentication
Username:       sa
Password:       contraseña configurada en SQL Server
```

La conexión inicial debe usar `master`, porque el propio script crea la base
`Northwind`.

5. Seleccionar **Test Connection**.
6. Si la prueba termina correctamente, seleccionar **Finish**.

### Error de certificado en una instancia local

Si una instancia exclusivamente local presenta un error de certificado, se
puede habilitar **Trust server certificate** en la configuración SSL o usar la
propiedad del driver:

```text
trustServerCertificate=true
```

Esta excepción no se recomienda para servidores remotos o ambientes de
producción.

## 3. Preparar la ejecución

Antes de abrir el archivo:

1. confirmar que la conexión activa apunta al servidor correcto;
2. confirmar que la base `Northwind` se puede eliminar o que todavía no existe;
3. usar una cuenta con permiso para crear y eliminar bases de datos;
4. comprobar que la conexión está en modo **Auto-commit**.

La creación de una base de datos no debe ejecutarse dentro de una transacción
manual abierta.

## 4. Abrir el script

1. Seleccionar la conexión de SQL Server que apunta a `master`.
2. Ir a **SQL Editor → Open SQL Script**.
3. Seleccionar el archivo `data/Northwind.sql`.
4. Revisar en la barra superior que el editor esté asociado con la conexión
   correcta.

No se debe ejecutar el script conectado inicialmente a SQLite ni a una base
distinta de la instancia SQL Server preparada para el ejercicio.

## 5. Comprobar el delimitador `GO`

El driver oficial de SQL Server normalmente reconoce `GO` como separador de
lotes. Si DBeaver muestra un error similar a este:

```text
Incorrect syntax near 'GO'
```

revisar la configuración:

```text
Preferences
└── Editors
    └── SQL Editor
        └── SQL Processing
```

Configurar el delimitador de sentencias como `GO`. Si DBeaver divide
incorrectamente los bloques `BEGIN/END` por los puntos y coma, habilitar
**Ignore native delimiter**.

El archivo puede contener `GO` y `go`. Si la versión de DBeaver los interpreta
de forma sensible a mayúsculas, trabajar sobre una copia del script y
normalizar las líneas separadoras a `GO`.

## 6. Ejecutar el script completo

Después de revisar la advertencia sobre la eliminación de `Northwind`:

1. seleccionar **SQL Editor → Execute SQL Script**; o
2. usar el atajo `Alt+X`.

No usar `Ctrl+Enter` para este procedimiento: ese atajo ejecuta solamente la
sentencia actual o el texto seleccionado.

El archivo es extenso, por lo que se debe esperar a que finalice y revisar el
registro completo de ejecución antes de repetirlo.

## 7. Verificar la base creada

Comprobar primero que `Northwind` exista:

```sql
SELECT name
FROM sys.databases
WHERE name = 'Northwind';
```

Después consultar algunas tablas:

```sql
USE Northwind;
GO

SELECT COUNT(*) AS Customers
FROM dbo.Customers;

SELECT COUNT(*) AS Products
FROM dbo.Products;

SELECT COUNT(*) AS Orders
FROM dbo.Orders;
```

En el navegador de DBeaver:

1. seleccionar la conexión y pulsar `F5` o **Refresh**;
2. abrir **Databases**;
3. buscar **Northwind**;
4. navegar a **Schemas → dbo → Tables**.

También se pueden revisar **Views** y **Procedures** para confirmar que el
script completo terminó correctamente.

## 8. Si se desea usar únicamente un motor embebido

DBeaver permite crear conexiones a motores basados en archivos, como SQLite,
sin instalar un servidor independiente. Sin embargo, el script tendría que
convertirse antes de ejecutarlo.

La conversión requeriría, como mínimo:

- eliminar `CREATE DATABASE`, `USE master` y las consultas a catálogos de SQL
  Server;
- eliminar los separadores `GO`;
- reemplazar `IDENTITY` por claves autoincrementales compatibles;
- adaptar `nvarchar`, `ntext`, `money`, `datetime`, `bit` e `image`;
- eliminar `CLUSTERED` y `SET IDENTITY_INSERT`;
- adaptar las vistas;
- descartar o reescribir los procedimientos almacenados.

Esta alternativa cambia el propósito del ejercicio y puede producir una base
que no se comporte igual que SQL Server. Para conservar Northwind completo, se
recomienda mantener SQL Server como motor y usar DBeaver como única interfaz.

## Problemas frecuentes

### La conexión es rechazada

Verificar:

- que SQL Server esté iniciado;
- que el puerto configurado sea el correcto;
- que el puerto esté expuesto si se usa Docker;
- que el usuario y la contraseña sean válidos;
- que SQL Server acepte autenticación mediante usuario y contraseña.

### No aparece la base después de ejecutar el script

Actualizar el navegador con `F5`. Si todavía no aparece, revisar el registro de
ejecución desde el primer error: los errores posteriores pueden ser solo una
consecuencia del fallo inicial.

### El script se detiene en `CREATE DATABASE`

Confirmar que el editor esté conectado a `master`, que el usuario tenga permiso
para crear bases y que Auto-commit esté habilitado.

### El script se detiene en `GO`

Revisar el delimitador del editor y confirmar que la conexión use el driver
oficial de SQL Server, no un driver genérico configurado manualmente.

## Referencias

- [SQL Server en DBeaver](https://dbeaver.com/docs/dbeaver/Database-driver-Microsoft-SQL-Server/)
- [Crear una conexión en DBeaver](https://dbeaver.com/docs/dbeaver/Create-Connection/)
- [Ejecutar scripts SQL en DBeaver](https://dbeaver.com/docs/dbeaver/SQL-Execution/)
- [SQL Server en contenedores Docker](https://learn.microsoft.com/es-es/sql/linux/quickstart-install-connect-docker?view=sql-server-ver17)
- [SQLite en DBeaver](https://dbeaver.com/docs/dbeaver/Database-driver-SQLite/)
