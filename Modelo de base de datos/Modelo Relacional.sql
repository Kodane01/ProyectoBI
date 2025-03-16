drop database BD_iowa_liquor
CREATE DATABASE BD_iowa_liquor
use BD_iowa_liquor


CREATE TABLE Proveedor (
    Numero_proveedor INT PRIMARY KEY,
    Nombre_proveedor VARCHAR(255)
)


CREATE TABLE Producto (
    Codigo_producto INT PRIMARY KEY,
    Nombre_Producto VARCHAR(255),
    Descripcion_producto VARCHAR(255),
    Empaque FLOAT,
    Volumen_botella DECIMAL(10, 2),
    Cantidad_pago_botella_ordenada DECIMAL(10, 2),
    Numero_proveedor INT,
    FOREIGN KEY (Numero_proveedor) REFERENCES Proveedor(Numero_proveedor),
)


CREATE TABLE Ciudad (
    Codigo_postal INT PRIMARY KEY,
    Ciudad VARCHAR(100)
)


CREATE TABLE Condado (
    Numero_condado INT PRIMARY KEY,
    Condado VARCHAR(100),
	Codigo_postal INT,
    FOREIGN KEY (Codigo_postal) REFERENCES Ciudad(Codigo_postal),
)


CREATE TABLE Ubicacion (
    Numero_ubicacion INT PRIMARY KEY,
    Direccion VARCHAR(100),
	Longitud VARCHAR(255),
    Latitud VARCHAR(255),
	Numero_condado INT,
    FOREIGN KEY (Numero_condado) REFERENCES Condado(Numero_condado),
)

CREATE TABLE Tienda (
    Numero_tienda INT PRIMARY KEY,
    Nombre_tienda VARCHAR(255),
    Numero_ubicacion INT,
    FOREIGN KEY (Numero_ubicacion) REFERENCES Ubicacion(Numero_ubicacion),
)

CREATE TABLE Factura (
    Numero_factura VARCHAR(255) PRIMARY KEY,
    Numero_tienda INT,
	Fecha DATE,
	Monto_total FLOAT,
    FOREIGN KEY (Numero_tienda) REFERENCES Tienda(Numero_tienda),
)

CREATE TABLE Detalles_Venta (
    Numero_factura VARCHAR(255),
	Codigo_producto INT,
    Cantidad_pago_botella_pedido DECIMAL(10, 2),
    Num_botellas_pedidas INT,
    Volumen_vendido_litros DECIMAL(15, 2),
    Volumen_vendido_galones DECIMAL(15, 2),
    FOREIGN KEY (Codigo_producto) REFERENCES Producto(Codigo_producto),
    FOREIGN KEY (Numero_factura) REFERENCES Factura(Numero_factura)
)


----------------------------------------------
--		SELECCIÓN DE TABLAS 
---------------------------------------------

select*from[dbo].[Ciudad]
select*from[dbo].[Condado]
select*from[dbo].[Detalles_Venta]
select*from[dbo].[Factura]
select*from[dbo].[Producto] 
select*from[dbo].[Proveedor]
select*from[dbo].[Tienda] 
select*from[dbo].[Ubicacion]


----------------------------------------------
--		BORRAR TABLAS 
---------------------------------------------

--drop table [dbo].[Proveedor]
--drop table [dbo].[Producto]
--drop table [dbo].[Detalles_Venta]
--drop table [dbo].[Factura]
--drop table [dbo].[Tienda]
--drop table [dbo].[Ubicacion]
--drop table [dbo].[Condado]
--drop table [dbo].[Ciudad]

------------------------------------------------------------
--		CONSULTA PARA PASAR LOS REGISTROS DE EXCEL A SQL
------------------------------------------------------------

------------------------------------------------------------
-- CIUDAD(433)
------------------------------------------------------------
BULK INSERT BD_iowa_liquor.dbo.Ciudad
FROM 'D:\ciclos UNFV\ciclo VI\Gestion BD\PROYECTO FINAL\documentos_excel_45mil_datos\Excel_Iowa_Liquor\Excel_Iowa_Liquor\Ciudad.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK                  -- Ayuda a acelerar la operación de inserción masiva
)

------------------------------------------------------------
-- CONDADO(99)
------------------------------------------------------------
BULK INSERT [BD_iowa_liquor].[dbo].[Condado]
FROM 'D:\ciclos UNFV\ciclo VI\Gestion BD\PROYECTO FINAL\documentos_excel_45mil_datos\Excel_Iowa_Liquor\Excel_Iowa_Liquor\Condado.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK                  -- Ayuda a acelerar la operación de inserción masiva
)
------------------------------------------------------------
-- UBICACION(1554)
------------------------------------------------------------
BULK INSERT [BD_iowa_liquor].[dbo].[Ubicacion]
FROM 'D:\ciclos UNFV\ciclo VI\Gestion BD\PROYECTO FINAL\documentos_excel_45mil_datos\Excel_Iowa_Liquor\Excel_Iowa_Liquor\Ubicacion.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK                  -- Ayuda a acelerar la operación de inserción masiva
)
------------------------------------------------------------
-- PROVEEDOR(172)
------------------------------------------------------------
BULK INSERT [BD_iowa_liquor].[dbo].[Proveedor]
FROM 'D:\ciclos UNFV\ciclo VI\Gestion BD\PROYECTO FINAL\documentos_excel_45mil_datos\Excel_Iowa_Liquor\Excel_Iowa_Liquor\Proveedor.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK                  -- Ayuda a acelerar la operación de inserción masiva
)
------------------------------------------------------------
-- PRODUCTO(99)
------------------------------------------------------------
BULK INSERT [BD_iowa_liquor].[dbo].[Producto]
FROM 'D:\ciclos UNFV\ciclo VI\Gestion BD\PROYECTO FINAL\documentos_excel_45mil_datos\Excel_Iowa_Liquor\Excel_Iowa_Liquor\Producto.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK                  -- Ayuda a acelerar la operación de inserción masiva
)
------------------------------------------------------------
-- TIENDA(1679)
------------------------------------------------------------
BULK INSERT [BD_iowa_liquor].[dbo].[Tienda]
FROM 'D:\ciclos UNFV\ciclo VI\Gestion BD\PROYECTO FINAL\documentos_excel_45mil_datos\Excel_Iowa_Liquor\Excel_Iowa_Liquor\Tienda.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK                  -- Ayuda a acelerar la operación de inserción masiva
)

------------------------------------------------------------
-- DETALLE_VENTA(1045752)
------------------------------------------------------------

BULK INSERT [BD_iowa_liquor].[dbo].[Detalles_Venta]
FROM 'D:\ciclos UNFV\ciclo VI\Gestion BD\PROYECTO FINAL\documentos_excel_45mil_datos\Excel_Iowa_Liquor\Excel_Iowa_Liquor\Detalles_venta.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK                  -- Ayuda a acelerar la operación de inserción masiva
)


------------------------------------------------------------
-- FACTURA(1045752)
------------------------------------------------------------
BULK INSERT [BD_iowa_liquor].[dbo].[Factura]
FROM 'D:\ciclos UNFV\ciclo VI\Gestion BD\PROYECTO FINAL\documentos_excel_45mil_datos\Excel_Iowa_Liquor\Excel_Iowa_Liquor\Factura.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    TABLOCK                  -- Ayuda a acelerar la operación de inserción masiva
)


-------------------------------------------------------------
-- PROBLEMA SOLUCIONADO (NO COMPILAR)
------------------------------------------------------------

/*
	SELECT * FROM Producto
	WHERE Codigo_producto = 1011100

	SELECT * FROM Factura
	WHERE Fecha = '2012-04-26' AND Numero_tienda = 2106 

	select*from[dbo].[Detalles_Venta]
	WHERE Codigo_producto = 1011100


	SELECT Codigo_producto, SUM (Num_botellas_pedidas) AS [BOTELLAS VENDIDAS], SUM(Cantidad_pago_botella_pedido) [VENTA], 
			SUM (Volumen_vendido_litros) [Venta_Volumen], SUM(Volumen_vendido_galones) [Venta Galon]
	FROM Detalles_Venta 
	WHERE Codigo_producto = 1011100
	GROUP BY Codigo_producto

	select DV.Numero_factura, DV.Codigo_producto, DV.Cantidad_pago_botella_pedido, DV.Num_botellas_pedidas,
			F.Numero_factura, F.Numero_Tienda FROM [dbo].[Detalles_Venta] DV 
	INNER JOIN Factura F ON DV.Numero_factura = F.Numero_factura
	WHERE Codigo_producto = 1011100 AND Numero_tienda = 2106 
	AND Numero_factura IN ('S05242500007', 'S05242500011', 'S05242500021', 'S05242500022',
	'S05242500027', 'S05242500044', 'S05242500046', 'S05242500050', 'S05242500065')

use master
drop database BD_iowa_liquor

select*from[dbo].[Factura]
where Numero_tienda = 3869 and Fecha = '2012-07-30'
*/