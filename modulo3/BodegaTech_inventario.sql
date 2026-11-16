-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: [Bruno Coccetta]
-- Fecha: [16-11-2026]
-- ══════════════════════════════════════════
USE Practica;

-- ── SECCIÓN DDL ──────────────────────────
-- DROP TABLE

DROP TABLE IF EXISTS inventario; --Aca si una tabla con el mismo nombre existe la eliminamos asi podemos crear una nueva sin problemas.

-- CREATE TABLE
CREATE TABLE inventario(
 id_producto INT NOT NULL IDENTITY (1,1) PRIMARY KEY, --Definimos la clave primaria como entero y le asignamos autoincrementarse de 1 en 1
 nombre_producto VARCHAR(100) NOT NULL,
 categoria VARCHAR(50) NOT NULL,
 precio_unitario DECIMAL(10,2) NOT NULL, --no le asignamos tipo de dato entero porque aveces varian los decimales en los precios
 stock_actual INT NOT NULL,
 stock_minimo INT NOT NULL, --En ambos stocks son enteros porque  trabajamos con productos que no se pueden dividir en partes
 fecha_ingreso DATE NOT NULL, -- Elegimos este tipo de datos porque en esta tabla no necesitamos saber a que hora ingresan los productos, solo cuando entran y cuantos
 activo TINYINT NOT NULL
);



-- ── SECCIÓN DML ──────────────────────────
-- INSERT INTO
INSERT INTO inventario
(nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES
('Laptop Pro 15', 'Computación', 1200.00, 15, 3, '2024-01-10', 1),
('Mouse inalámbrico','Accesorios', 28.00, 80, 10,'2024-01-10',1),
('Monitor 4K 27"','Computación', 450.00, 12, 2,'2024-01-15',1),
('Teclado Mecánico','Accesorios', 95.00, 40, 5,'2024-01-15',1),
('Laptop Basic 14','Computación', 650.00, 20, 3,'2024-02-01',1),
('Auriculares BT Pro','Audio', 120.00, 35, 5,'2024-02-01',1),
('Hub USB-C 7 puertos','Accesorios', 45.00, 60, 10,'2024-02-10',1),
('Webcam HD 1080p','Accesorios', 85.00, 25, 5,'2024-02-10',1),
('SSD Externo 1TB','Almacenamiento', 130.00, 18, 3,'2024-03-01',1),
('Parlante Bluetooth','Audio', 60.00, 45, 8,'2024-03-01',1);

-- UPDATE ventas del día
UPDATE inventario SET stock_actual = stock_actual - 3
WHERE id_producto = 1;
UPDATE inventario SET stock_actual = stock_actual - 12
WHERE id_producto = 2;
UPDATE inventario SET stock_actual = stock_actual - 5
WHERE id_producto = 6;
-- UPDATE producto descontinuado
UPDATE inventario SET activo = 0
WHERE id_producto = 8;
-- SELECT validaciones
SELECT *FROM inventario;

