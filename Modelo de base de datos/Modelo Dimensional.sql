----------------------------------------------------------------
-- CREATE DATABASE BD_iowa_liquor_Dim
----------------------------------------------------------------
drop database BD_Iowa_Liquor_Dim
use BD_Iowa_Liquor_Dim
CREATE DATABASE BD_Iowa_Liquor_Dim -- *** SOLO COMPILAR ESTA LÍNEA ***
ON PRIMARY -- almacena las tablas, índices, procedimientos almacenados y otros objetos de la base de datos
(
NAME = 'BD_Iowa_Liquor_Dimensional_Data',
FILENAME = 'D:\UNFV\VI CICLO\GESTIÓN Y ANÁLISIS DE DATOS E INFORMACIÓN\PROYECTO\BD_Iowa_Liquor_Dimensional.mdf',
SIZE = 800MB,
MAXSIZE = 25024MB,
FILEGROWTH = 30%
)

LOG ON -- almacena la información del registro de transacciones para la base de datos.
(
NAME = 'BD_Iowa_Liquor_Dimensional_Log',
FILENAME = 'D:\UNFV\VI CICLO\GESTIÓN Y ANÁLISIS DE DATOS E INFORMACIÓN\PROYECTO\BD_Iowa_Liquor_Dimensional.ldf',
SIZE = 700 MB,
MAXSIZE = 20000 MB,
FILEGROWTH = 30%
)
ALTER DATABASE BD_Iowa_Liquor_Dim

ADD FILE (
    NAME = 'BD_Iowa_Liquor_Dimensional_Data_2',  -- Nombre lógico del nuevo archivo
    FILENAME = 'D:\UNFV\VI CICLO\GESTIÓN Y ANÁLISIS DE DATOS E INFORMACIÓN\PROYECTO\BD_Iowa_Liquor_Dimensional_2.ndf',  -- Ruta del nuevo archivo
    SIZE = 800 MB,  -- Tamaño inicial del nuevo archivo
    MAXSIZE = 25000 MB,  -- Tamaño máximo permitido
    FILEGROWTH = 30%  -- Incremento automático del archivo en un 50%
)

	--use master
	--DROP DATABASE BD_Iowa_Liquor_Dim
	--use BD_iowa_liquor_dim


------------------------------------------------------------------
--	CREACION DE LAS TABLAS DIMENSION
------------------------------------------------------------------

------------------------------------------------------------------
--			DIMENSION PRODUCTO
------------------------------------------------------------------
create table DIM_Producto(
    Codigo_producto INT PRIMARY KEY,
    Nombre_Producto VARCHAR(255),
    Descripcion_producto VARCHAR(255),
    Empaque FLOAT,
    Volumen_botella DECIMAL(10, 2),
    Cantidad_pago_botella_ordenada DECIMAL(10, 2)
)

------------------------------------------------------------------
--			DIMENSION TIENDA
------------------------------------------------------------------
create table DIM_Tienda(
    Numero_tienda INT PRIMARY KEY,
    Nombre_tienda VARCHAR(255),
    Direccion VARCHAR(100),
	Longitud VARCHAR(255),
    Latitud VARCHAR(255),
    Condado VARCHAR(100),
    Ciudad VARCHAR(100)
)

------------------------------------------------------------------
--			DIMENSION TIEMPO
------------------------------------------------------------------
create table DIM_Tiempo(
	id_tiempo int primary key identity (1,1),
	fecha date,
	año int,
	trimestre int,
	nombre_mes varchar(50),
)

------------------------------------------------------------------
--			TABLA DE HECHOS FACT_VENTA
------------------------------------------------------------------
create table FACT_VENTA(
	Codigo_producto int foreign key references DIM_Producto(Codigo_producto),
	Numero_tienda int foreign key references DIM_Tienda(Numero_tienda),
	id_tiempo int foreign key references DIM_Tiempo(id_tiempo),
    Cantidad_pago_botella_pedido DECIMAL(10, 2),
    Num_botellas_pedidas INT,
    Volumen_vendido_litros DECIMAL(15, 2),
    Volumen_vendido_galones DECIMAL(15, 2),
	primary key (Codigo_producto, Numero_tienda, id_Tiempo)
)


--------------------------------------------------------------------------------
-- STORE PROCEDURE PARA DIM_PRODUCTO
--------------------------------------------------------------------------------
CREATE PROCEDURE sp_DIM_Producto
AS
BEGIN
    SET NOCOUNT ON

    -- Desactiva índices y restricciones
    ALTER TABLE BD_iowa_liquor_dim.dbo.DIM_Producto NOCHECK CONSTRAINT ALL

    -- Realiza la inserción en lotes
    INSERT INTO BD_iowa_liquor_dim.dbo.DIM_Producto (Codigo_producto, Nombre_Producto, Descripcion_producto, Empaque, Volumen_botella, Cantidad_pago_botella_ordenada)
    SELECT Codigo_producto, Nombre_Producto, Descripcion_producto, Empaque, Volumen_botella, Cantidad_pago_botella_ordenada
    FROM BD_iowa_liquor.dbo.Producto

    -- Reactiva índices y restricciones
    ALTER TABLE BD_iowa_liquor_dim.dbo.DIM_Producto WITH CHECK CHECK CONSTRAINT ALL
END


-- EJECUTANDO STORE PROCEDURE SP_DIM_PRODUCTO
EXEC sp_DIM_Producto
select * from DIM_Producto   --(99)

--------------------------------------------------------------------------------
-- STORE PROCEDURE PARA DIM_TIENDA
--------------------------------------------------------------------------------

CREATE PROCEDURE sp_DIM_Tienda
AS
BEGIN
    SET NOCOUNT ON

    -- Desactiva índices y restricciones
    ALTER TABLE BD_iowa_liquor_dim.dbo.DIM_Tienda NOCHECK CONSTRAINT ALL

    -- Realiza la inserción en lotes
    INSERT INTO BD_iowa_liquor_dim.dbo.DIM_Tienda (Numero_tienda, Nombre_tienda, Direccion, Longitud, Latitud, Condado, Ciudad)
    SELECT 
        T.Numero_tienda,
        T.Nombre_tienda,
        U.Direccion,
        U.Longitud,
        U.Latitud,
        Cnd.Condado,
        Cdd.Ciudad
    FROM BD_iowa_liquor.dbo.Tienda T
    INNER JOIN BD_iowa_liquor.dbo.Ubicacion U ON T.Numero_ubicacion = U.Numero_ubicacion
    INNER JOIN BD_iowa_liquor.dbo.Condado Cnd ON U.Numero_condado = Cnd.Numero_condado
    INNER JOIN BD_iowa_liquor.dbo.Ciudad Cdd ON Cnd.Codigo_postal = Cdd.Codigo_postal

    -- Reactiva índices y restricciones
    ALTER TABLE BD_iowa_liquor_dim.dbo.DIM_Tienda WITH CHECK CHECK CONSTRAINT ALL
END

-- EJECUTANDO STORE PROCEDURE SP_DIM_TIENDA
EXEC sp_DIM_Tienda
select * from DIM_Tienda  --(1679)


--------------------------------------------------------------------------------
-- STORE PROCEDURE PARA DIM_TIEMPO
--------------------------------------------------------------------------------

CREATE PROCEDURE sp_DIM_Tiempo
AS
BEGIN
    SET NOCOUNT ON;

    -- Desactiva índices y restricciones
    ALTER TABLE BD_iowa_liquor_dim.dbo.DIM_Tiempo NOCHECK CONSTRAINT ALL

    -- Realiza la inserción en lotes
    INSERT INTO BD_iowa_liquor_dim.dbo.DIM_Tiempo (fecha, año, trimestre, nombre_mes)
    SELECT DISTINCT
		   fecha,
           YEAR(fecha) AS año,
           DATEPART(QUARTER, fecha) AS trimestre,
           DATENAME(MONTH, fecha) AS nombre_mes
    FROM BD_iowa_liquor.dbo.Factura

    -- Reactiva índices y restricciones
    ALTER TABLE BD_iowa_liquor_dim.dbo.DIM_Tiempo WITH CHECK CHECK CONSTRAINT ALL
END

-- EJECUTANDO STORE PROCEDURE SP_DIM_TIEMPO
EXEC sp_DIM_Tiempo
select * from DIM_Tiempo --(1018)

--------------------------------------------------------------------------------
-- STORE PROCEDURE PARA LA TABLA HECHOS FACT_VENTA
--------------------------------------------------------------------------------

CREATE PROCEDURE sp_FACT_VENTA
AS
BEGIN
    -- Desactiva índices y restricciones
    -- ALTER TABLE BD_iowa_liquor_dim.dbo.FACT_VENTA NOCHECK CONSTRAINT ALL

    -- Realiza la inserción en lotes
    INSERT INTO BD_iowa_liquor_dim.dbo.FACT_VENTA (Codigo_producto, Numero_tienda, id_tiempo, Cantidad_pago_botella_pedido, Num_botellas_pedidas, Volumen_vendido_litros, Volumen_vendido_galones)
    SELECT 
        DV.Codigo_producto,
        F.Numero_tienda,
        DT.id_tiempo,
        SUM(DV.Cantidad_pago_botella_pedido) AS Cantidad_pago_botella_pedido,
        SUM(DV.Num_botellas_pedidas) AS Num_botellas_pedidas,
        SUM(DV.Volumen_vendido_litros) AS Volumen_vendido_litros,
        SUM(DV.Volumen_vendido_galones) AS Volumen_vendido_galones
    FROM BD_iowa_liquor.dbo.Detalles_Venta DV
    INNER JOIN BD_iowa_liquor.dbo.Factura F ON DV.Numero_factura = F.Numero_factura
    INNER JOIN BD_iowa_liquor_dim.dbo.DIM_Tiempo DT ON DT.fecha = F.Fecha
    GROUP BY DV.Codigo_producto, F.Numero_tienda, DT.id_tiempo

    -- Reactiva índices y restricciones
    -- ALTER TABLE BD_iowa_liquor_dim.dbo.FACT_VENTA WITH CHECK CHECK CONSTRAINT ALL
END


-- EJECUTANDO STORE PROCEDURE SP_FACT_VENTA
exec sp_FACT_VENTA
select * from Fact_Venta  --(838720)

-------------------------------------------------------------
-- PROBLEMA SOLUCIONADO (NO COMPILAR)
------------------------------------------------------------
	SELECT *
	FROM DIM_Tienda
	WHERE Numero_tienda = 2106

	SELECT * FROM DIM_Producto
	WHERE Codigo_producto = 1011100

	SELECT * FROM DIM_Tiempo
	WHERE id_tiempo = 4

-- 838 720 FILAS (REGISTROS) TABLA DE HECHOS
-- 205,978 DATOS BORRADOS DEL DATASET EN LA LIMPIEZA



SELECT 
   dp.nombre_producto, (fv.Cantidad_pago_botella_pedido - dp.Cantidad_pago_botella_ordenada) * fv.Num_botellas_pedidas AS Utilidad
FROM 
    FACT_VENTA fv
JOIN 
    DIM_Producto dp ON fv.Codigo_producto = dp.Codigo_producto;