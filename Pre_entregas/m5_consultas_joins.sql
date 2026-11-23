-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Propósito: Consolidar en una vista única todas las ventas junto con los datos descriptivos de clientes, productos y categorías para alimentar el análisis en Power BI.
SELECT
	v.id_venta,
	v.fecha_venta,
	c.nombre AS cliente,
	c.ciudad,
	p.nombre_producto,
	cat.nombre_categoria,
	v.cantidad,
	v.precio_unitario,
	(v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER  JOIN categorias cat ON p.id_categoria = cat.id_categoria;

-- Hallazgo: Se consolidaron 10 operaciones válidas (del 05/03/2024 al 15/03/2024) con sus dimensiones 
--de cliente, producto y categoría listas para Power BI, destacando la categoría Computación como la de mayor facturación individual.

--Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Propósito: Identificar clientes registrados que aún no realizaron ninguna compra para que el área de CRM gestione campañas de activación.
SELECT 
	c.nombre,
	c.email,
	c.fecha_registro 
FROM clientes c 
LEFT JOIN ventas v ON v.id_cliente = c.id_cliente 
WHERE v.id_venta IS NULL;

-- Hallazgo: Aparecieron 0 registros (todos los clientes registrados realizaron al menos 1 compra), 
--lo que indica al área de CRM que no existen cuentas inactivas que requieran campañas de primera activación.

--Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Propósito: Detectar artículos del catálogo sin ventas registradas para que el área de Producto evalúe su rotación comercial o estrategias de promoción.
SELECT 
	p.nombre_producto, 
	cat.nombre_categoria, 
	p.precio 
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON v.id_producto = p.id_producto 
WHERE v.id_venta IS NULL;

-- Hallazgo: Aparecieron 0 registros (todos los productos del catálogo tuvieron al menos una venta), 
--lo que confirma al área de Producto que todo el surtido actual tiene rotación comercial.

--Consulta 4 — Consolidado por canal (UNION ALL)
-- Propósito: Comparar el volumen total de facturación entre el canal Online y el canal Presencial.
SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Online' AS canal
    FROM ventas WHERE ventas.id_venta <= 5
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Presencial' AS canal
    FROM ventas WHERE ventas.id_venta > 5
) AS consolidado
GROUP BY canal;

-- Hallazgo: El canal Online lidera la facturación con $3620.00 frente a los $2824.00 del canal Presencial, representando el 56.2% de las ventas totales.