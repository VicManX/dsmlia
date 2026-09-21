-- ASSIGNMENT 03
--01 Selecciona la base de datos 'Northwind'
USE Northwind;
GO

--02 Utiliza la sentencia SELECT para consultar la tabla
--Employees. Selecciona EmployeeID, LastName y FirstName
SELECT
	e.EmployeeID,
	e.LastName,
	e.FirstName
FROM Employees AS e;

--03 Utiliza clausula WHERE para filtrar los Empleados que
--son de Londres (London)
SELECT
	e.EmployeeID,
	e.LastName,
	e.FirstName
FROM Employees AS e
WHERE e.City='London';

--04 Agrupa y ordena de manera descendente la cantidad de
--empleados por ciudad (City)
SELECT
	e.City,
	COUNT(*) as QtyEmployees
FROM Employees AS e
GROUP BY e.City
ORDER BY 2 DESC;

--05 Inserta los siguientes datos a la tabla Employees
--05.01
DECLARE
	@LastName NVARCHAR(50) = N'Porras',
	@FirstName NVARCHAR(50) = N'Victor';

BEGIN TRY
	BEGIN TRAN;

	INSERT into Employees (LastName, FirstName)
	OUTPUT inserted.EmployeeID
	VALUES (@LastName, @FirstName);

	COMMIT TRAN;
END TRY

BEGIN CATCH
	ROLLBACK TRAN;
	THROW;
END CATCH;
GO

-- 05.02 Alternativa de inserción directa: ejecutar solo si no se ejecutó 05.01.
INSERT INTO Employees (LastName, FirstName)
VALUES (N'Porras', N'Victor');
GO

--06 De la tabla [Order Details] calcula el
--COUNT, AVG, SUM, MIN y MAX de la columna
--'Quantity'
SELECT
	COUNT(Quantity) AS TotalOrdenes,
	AVG(Quantity) AS CantidadMediaPorOrden,
	SUM(Quantity) AS TotalUnidadesVendidas,
	MIN(Quantity) AS MinCantPorOrden,
	MAX(Quantity) AS MaxCantPorOrden

FROM [Order Details];
