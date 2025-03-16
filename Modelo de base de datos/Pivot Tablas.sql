------------------------------------------------------------------
--						PIVOT
------------------------------------------------------------------

-- I) INDICADOR VENTAS

---------------------------------------------------
-- 1) Ventas por trimestre del año 2012
---------------------------------------------------

SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
		'Q' + CAST(TT.trimestre AS VARCHAR) + ' ' + CAST(TT.año AS VARCHAR) AS Trimestre,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
	JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año = 2012
    GROUP BY T.Nombre_tienda, TT.trimestre, TT.año
) AS SourceTable
PIVOT (
    SUM(MontoTotal) FOR Trimestre IN ([Q1 2012], [Q2 2012], [Q3 2012], [Q4 2012])
) AS PivotTable
ORDER BY [Q4 2012] DESC

---------------------------------------------------
-- 2) Ventas por trimestre del año 2013
---------------------------------------------------
SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
		'Q' + CAST(TT.trimestre AS VARCHAR) + ' ' + CAST(TT.año AS VARCHAR) AS Trimestre,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
	JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año = 2013
	GROUP BY T.Nombre_tienda, TT.trimestre, TT.año
) AS SourceTable
PIVOT (
     SUM(MontoTotal) FOR Trimestre IN ([Q1 2013], [Q2 2013], [Q3 2013], [Q4 2013])
) AS PivotTable
ORDER BY [Q4 2013] DESC

---------------------------------------------------
-- 3) Ventas por trimestre del año 2014
---------------------------------------------------
SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
		'Q' + CAST(TT.trimestre AS VARCHAR) + ' ' + CAST(TT.año AS VARCHAR) AS Trimestre,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
	JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año = 2014
	GROUP BY T.Nombre_tienda, TT.trimestre, TT.año
) AS SourceTable
PIVOT (
     SUM(MontoTotal) FOR Trimestre IN ([Q1 2014], [Q2 2014], [Q3 2014], [Q4 2014])
) AS PivotTable
ORDER BY [Q4 2014] DESC

---------------------------------------------------
-- 3) Ventas por trimestre del año 2015
---------------------------------------------------

SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
		'Q' + CAST(TT.trimestre AS VARCHAR) + ' ' + CAST(TT.año AS VARCHAR) AS Trimestre,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
	JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año = 2015
	GROUP BY T.Nombre_tienda, TT.trimestre, TT.año
) AS SourceTable
PIVOT (
    SUM(MontoTotal) FOR Trimestre IN ([Q1 2015], [Q2 2015], [Q3 2015], [Q4 2015])
) AS PivotTable
ORDER BY [Q4 2015] DESC

---------------------------------------------------
-- 4) Ventas por trimestre del año 2016
---------------------------------------------------

SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
		'Q' + CAST(TT.trimestre AS VARCHAR) + ' ' + CAST(TT.año AS VARCHAR) AS Trimestre,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
	JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año = 2016
	GROUP BY T.Nombre_tienda, TT.trimestre, TT.año
) AS SourceTable
PIVOT (
    SUM(MontoTotal) FOR Trimestre IN ([Q1 2016], [Q2 2016], [Q3 2016], [Q4 2016])
) AS PivotTable
ORDER BY [Q4 2016] DESC

---------------------------------------------------
-- 4) Ventas por trimestre del año 2017
---------------------------------------------------

SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
		'Q' + CAST(TT.trimestre AS VARCHAR) + ' ' + CAST(TT.año AS VARCHAR) AS Trimestre,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
	JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año = 2017
	GROUP BY T.Nombre_tienda, TT.trimestre, TT.año
) AS SourceTable
PIVOT (
    SUM(MontoTotal) FOR Trimestre IN ([Q1 2017], [Q2 2017], [Q3 2017], [Q4 2017])
) AS PivotTable
ORDER BY [Q4 2017] DESC

---------------------------------------------------
-- 4) Ventas por trimestre del año 2018
---------------------------------------------------

SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
		'Q' + CAST(TT.trimestre AS VARCHAR) + ' ' + CAST(TT.año AS VARCHAR) AS Trimestre,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
	JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año = 2018
	GROUP BY T.Nombre_tienda, TT.trimestre, TT.año
) AS SourceTable
PIVOT (
    SUM(MontoTotal) FOR Trimestre IN ([Q1 2018], [Q2 2018], [Q3 2018], [Q4 2018])
) AS PivotTable
ORDER BY [Q4 2018] DESC

---------------------------------------------------
-- 5) Ventas por año 2012 - 2018
---------------------------------------------------

-- POR PRODUCTO Y TIENDA (POR EVALUAR 38K REGISTROS)

--SELECT *
--FROM (
--    SELECT 
--        T.Nombre_tienda,
--        P.Nombre_Producto,
--        TT.año AS Anio,
--        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
--    FROM FACT_VENTA FV
--    JOIN DIM_Producto P ON FV.Codigo_producto = P.Codigo_producto
--    JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
--    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
--    WHERE TT.año BETWEEN 2012 AND 2018
--    GROUP BY T.Nombre_tienda, P.Nombre_Producto, TT.año
--) AS SourceTable
--PIVOT (
--    SUM(MontoTotal) FOR Anio IN ([2012], [2013], [2014], [2015], [2016], [2017], [2018])
--) AS PivotTable

-- POR TIENDA (1140 REGISTROS)
SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
        TT.año AS Anio,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
    JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año BETWEEN 2012 AND 2018
    GROUP BY T.Nombre_tienda, TT.año
) AS SourceTable
PIVOT (
    SUM(MontoTotal) FOR Anio IN ([2012], [2013], [2014], [2015], [2016], [2017], [2018])
) AS PivotTable
ORDER BY [2018] DESC

-- POR PRODUCTO
SELECT *
FROM (
    SELECT 
        P.Nombre_Producto,
        TT.año AS Anio,
        SUM(FV.Cantidad_pago_botella_pedido * FV.Num_botellas_pedidas) AS MontoTotal
    FROM FACT_VENTA FV
    JOIN DIM_Producto P ON FV.Codigo_producto = P.Codigo_producto
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    WHERE TT.año BETWEEN 2012 AND 2018
    GROUP BY P.Nombre_Producto, TT.año
) AS SourceTable
PIVOT (
    SUM(MontoTotal) FOR Anio IN ([2012], [2013], [2014], [2015], [2016], [2017], [2018])
) AS PivotTable
ORDER BY [2018] DESC

---------------------------------------------------
-- II) INDICADOR - VOLUMEN
---------------------------------------------------

---------------------------------------------------
-- 1) Volumen total vendido por litros en los top 10 condados
---------------------------------------------------

WITH TopCondados AS (
    SELECT
        Condado,
        SUM(Volumen_vendido_litros) AS TotalVolumen
    FROM (
        SELECT 
            T.Condado,
            P.Nombre_Producto,
            FV.Volumen_vendido_litros,
            ROW_NUMBER() OVER (PARTITION BY T.Condado ORDER BY SUM(FV.Volumen_vendido_litros) DESC) AS RowNum
        FROM FACT_VENTA FV
        JOIN DIM_Producto P ON FV.Codigo_producto = P.Codigo_producto
        JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
        GROUP BY T.Condado, P.Nombre_Producto, FV.Volumen_vendido_litros
    ) AS RankedData
    WHERE RowNum <= 10
    GROUP BY Condado
)
SELECT *
FROM (
    SELECT 
        TC.Condado,
        P.Nombre_Producto,
        FV.Volumen_vendido_litros
    FROM FACT_VENTA FV
    JOIN DIM_Producto P ON FV.Codigo_producto = P.Codigo_producto
    JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
    JOIN TopCondados TC ON T.Condado = TC.Condado
) AS SourceTable
PIVOT (
    SUM(Volumen_vendido_litros) FOR Condado IN ([Polk], [Linn], [Dubuque], [Dallas], [Story], [Woodbury], [Scott], [Johnson], [Black Hawk], [Pottawattamie])
) AS PivotTable


---------------------------------------------------
--2) Volumen total vendido en litros por año y por tienda
---------------------------------------------------

SELECT *
FROM (
    SELECT 
        T.Nombre_tienda,
        TT.año AS Anio,
        FV.Volumen_vendido_litros
    FROM FACT_VENTA FV
    JOIN DIM_Producto P ON FV.Codigo_producto = P.Codigo_producto
    JOIN DIM_Tienda T ON FV.Numero_tienda = T.Numero_tienda
    JOIN DIM_Tiempo TT ON FV.id_tiempo = TT.id_tiempo
) AS SourceTable
PIVOT (
    SUM(Volumen_vendido_litros) FOR Anio IN ([2012], [2013], [2014], [2015], [2016], [2017], [2018])
) AS PivotTable

-- Contar productos por condado
SELECT
	P.Nombre_Producto,
    T.Condado,
    COUNT(P.Codigo_producto) AS TotalProductos
FROM DIM_Tienda T
JOIN FACT_VENTA FV ON T.Numero_tienda = FV.Numero_tienda
JOIN DIM_Producto P ON FV.Codigo_producto = P.Codigo_producto
GROUP BY T.Condado, P.Nombre_Producto
ORDER BY TotalProductos DESC

select distinct nombre_producto from DIM_Producto
select distinct Condado from DIM_Tienda


-- PIVOT de la cantidad de veces que cada producto aparece en cada condado
WITH ProductosPorCondado AS (
    SELECT
        T.Condado,
        P.Nombre_Producto,
        COUNT(*) AS CantidadVeces
    FROM DIM_Tienda T
    JOIN FACT_VENTA FV ON T.Numero_tienda = FV.Numero_tienda
    JOIN DIM_Producto P ON FV.Codigo_producto = P.Codigo_producto
    GROUP BY T.Condado, P.Nombre_Producto 
)
SELECT *
FROM ProductosPorCondado
PIVOT (
    SUM(CantidadVeces) FOR Condado IN ([Henry], [Calhoun], [Webster], [Van Buren], [Davis], [Johnson], [Winnebago], [Kossuth], [Wapello], [Lee],
                                      [Jasper], [Osceola], [Appanoose], [Winneshiek], [Taylor], [Plymouth], [Lucas], [Guthrie], [Jefferson], [Cherokee],
                                      [Polk], [Worth], [Humboldt], [Lyon], [Dickinson], [Ringgold], [Louisa], [Mitchell], [Des Moines], [Mills],
                                      [Ida], [Grundy], [Butler], [Clarke], [Palo Alto], [Jones], [Pottawattamie], [Monroe], [Clinton], [Chickasaw],
                                      [Franklin], [Poweshiek], [Wright], [Sac], [Sioux], [Jackson], [Woodbury], [Harrison], [O'Brien], [Clay], [Tama],
                                      [Shelby], [Warren], [Black Hawk], [Dallas], [Crawford], [Delaware], [Washington], [Adair], [Hamilton], [Emmet],
                                      [Marshall], [Monona], [Muscatine], [Benton], [Linn], [Audubon], [Cerro Gordo], [Scott], [Decatur], [Fayette], [Bremer],
                                      [Floyd], [Iowa], [Story], [Montgomery], [Buchanan], [Dubuque], [Hardin], [Pocahontas], [Clayton], [Union], [Boone],
                                      [Cedar], [Madison], [Marion], [Page], [Greene], [Keokuk], [Allamakee], [Buena Vista], [Carroll], [Hancock], [Cass],
                                      [Howard], [Mahaska], [Fremont], [Adams], [Wayne])
) AS PivotTable



