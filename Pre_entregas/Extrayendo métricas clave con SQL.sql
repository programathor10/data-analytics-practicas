-- ══════════════════════════════════════════
-- Proyecto: Pre-entrega 4 - Extrayendo métricas clave con SQL
-- Autor: [Bruno Coccetta]
-- Fecha: [20-11-2026]
-- Motor: SQL Server (SSMS)
-- ══════════════════════════════════════════
USE Ventas_Tech_DB;
GO

-- === CONSULTA 1: RESUMEN EJECUTIVO MENSUAL ===
SELECT 
SUM(cantidad * precio_unitario) AS total_facturado,
COUNT(id_venta) AS cantidad_pedidos,
CAST(AVG(cantidad * precio_unitario) AS decimal(10, 2)) AS ticket_promedio, 
MONTH (fecha_venta) AS mes
FROM ventas
GROUP BY MONTH(fecha_venta);
GO

-- === CONSULTA 2: TOP 5 PRODUCTOS POR FACTURACIÓN ===
SELECT TOP 5
	id_producto,
	SUM(cantidad) AS unidades_vendidas,
	SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;
GO

-- === CONSULTA 3 — CLIENTES RECURRENTES ===
SELECT 
	id_cliente,
	COUNT(*) AS cantidad_pedidos,
	SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;
GO

-- === CONSULTA 4 — PRODUCTOS POR ENCIMA/POR DEBAJO DEL PROMEDIO ===
WITH FacturacionPorProducto AS (
    SELECT 
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT 
    id_producto,
    total_facturado,
    CASE 
        WHEN total_facturado >= (SELECT AVG(total_facturado) FROM FacturacionPorProducto) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento
FROM FacturacionPorProducto
ORDER BY total_facturado DESC;
GO

-- === BLOQUE DE CIERRE: HALLAZGOS DE NEGOCIO ===
-- 1. Concentración de ingresos: El Producto 1 (Laptop Pro 15) concentra el 55,8% de 
-- toda la facturación de marzo ($3.600,00 sobre un total de $6.444,00) con apenas 3 unidades vendidas.

-- 2. Volumen vs. facturación: El Producto 2 (Mouse Inalámbrico) lidera ampliamente en unidades vendidas (13 unidades), 
-- pero representa solo el 5,6% de los ingresos ($364,00), quedando muy por debajo del promedio de facturación por producto ($1.074,00).

-- 3. Brecha mínima en el Top 5: Los Auriculares BT Pro (Producto 4) quedaron fuera del Top 5 
-- por apenas $4,00 de diferencia ($360,00 en 3 unidades frente a los $364,00 del Mouse Inalámbrico).