# Assignment 03 — Consultas y operaciones en Northwind

## Información

- **Sesión relacionada:** Semana 03 — SQL y bases de datos para Data Science.
- **Estado:** Finalizado.
- **Entregable principal:** `assignment_03.sql`.
- **Base de datos:** Northwind en SQL Server.

## Objetivo

Aplicar consultas SQL sobre la base de datos Northwind para seleccionar,
filtrar y agrupar datos de empleados; calcular métricas agregadas sobre los
detalles de pedidos; e insertar un nuevo registro de empleado de manera
controlada.


## Ejercicios

Los ejercicios se organizan según el enunciado de **Tarea 3**. Cada solución
también está disponible en `assignment_03.sql`.

### Ejercicio 1 — Seleccionar la base de datos

**Enunciado:** seleccionar la base de datos `Northwind`.

```sql
USE Northwind;
GO
```

### Ejercicio 2 — Consultar empleados

**Enunciado:** consultar la tabla `Employees` y mostrar `EmployeeID`,
`LastName` y `FirstName`.

```sql
SELECT
    e.EmployeeID,
    e.LastName,
    e.FirstName
FROM Employees AS e;
```

### Ejercicio 3 — Filtrar empleados de Londres

**Enunciado:** usar la cláusula `WHERE` para obtener los empleados cuya ciudad
es `London`.

```sql
SELECT
    e.EmployeeID,
    e.LastName,
    e.FirstName
FROM Employees AS e
WHERE e.City = 'London';
```

### Ejercicio 4 — Agrupar empleados por ciudad

**Enunciado:** agrupar la cantidad de empleados por `City` y ordenar el
resultado de manera descendente.

```sql
SELECT
    e.City,
    COUNT(*) AS QtyEmployees
FROM Employees AS e
GROUP BY e.City
ORDER BY 2 DESC;
```

### Ejercicio 5 — Insertar un empleado

**Enunciado:** insertar los datos personales del estudiante en la tabla
`Employees`. Para esta entrega se utilizan mis datos: `Porras` como apellido y
`Victor` como nombre.

**Solución recomendada:** la inserción se ejecuta dentro de una transacción.
Si ocurre un error, los cambios se revierten; si funciona, se muestra el
`EmployeeID` generado.

```sql
DECLARE
    @LastName NVARCHAR(50) = N'Porras',
    @FirstName NVARCHAR(50) = N'Victor';

BEGIN TRY
    BEGIN TRAN;

    INSERT INTO Employees (LastName, FirstName)
    OUTPUT inserted.EmployeeID
    VALUES (@LastName, @FirstName);

    COMMIT TRAN;
END TRY
BEGIN CATCH
    ROLLBACK TRAN;
    THROW;
END CATCH;
GO
```

**Alternativa incluida en el script:**

```sql
INSERT INTO Employees (LastName, FirstName)
VALUES (N'Porras', N'Victor');
GO
```

> Ejecutar solo una de las dos alternativas de este ejercicio. Si se ejecutan ambas, se insertará dos veces el empleado `Victor Porras`.

### Ejercicio 6 — Calcular agregados de pedidos

**Enunciado:** calcular `COUNT`, `AVG`, `SUM`, `MIN` y `MAX` de la columna
`Quantity` de la tabla de detalles de pedidos.

> En la versión de Northwind usada con SQL Server, la tabla se llama
> `[Order Details]`; por ello se emplean corchetes en la consulta.

```sql
SELECT
    COUNT(Quantity) AS TotalOrdenes,
    AVG(Quantity) AS CantidadMediaPorOrden,
    SUM(Quantity) AS TotalUnidadesVendidas,
    MIN(Quantity) AS MinCantPorOrden,
    MAX(Quantity) AS MaxCantPorOrden
FROM [Order Details];
```
