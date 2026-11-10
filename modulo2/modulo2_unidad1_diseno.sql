USE Practica;
GO

-- =============================================
-- 3. Define la Tabla de Clientes
-- =============================================
CREATE TABLE clientes (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY, -- INT: Número entero para identificar unívocamente al cliente con autoincremento.
    nombre VARCHAR(100) NOT NULL,            -- VARCHAR(100): Almacena texto de longitud variable hasta 100 caracteres optimizando espacio.
    perfil_bio VARCHAR(MAX),                  -- VARCHAR(MAX): Permite guardar textos largos o biografías sin límite corto prefijado.
    fecha_registro DATE DEFAULT GETDATE()     -- DATE: Guarda exclusivamente la fecha (año-mes-día) sin almacenar hora sobrante.
);

-- =============================================
-- 4. Define la Tabla de Productos
-- =============================================
CREATE TABLE productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY, -- INT: Clave primaria entera para la identificación única de cada producto.
    descripcion VARCHAR(255) NOT NULL,        -- VARCHAR(255): Texto de longitud variable estándar para descripciones o títulos.
    precio DECIMAL(10,2) NOT NULL,             -- DECIMAL(10,2): Garantiza precisión exacta para valores monetarios (10 dígitos en total y 2 decimales).
    esta_activo BIT DEFAULT 1                 -- BIT: Representa un estado booleano (1 = Activo / 0 = Inactivo) siendo la opción más ligera (1 byte).
);
GO
