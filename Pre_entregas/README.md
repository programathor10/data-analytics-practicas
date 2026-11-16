# Base de Datos Relacional: TechStore (`Ventas_Tech_DB`)

Implementación en SQL Server del modelo relacional normalizado (3NF) para la gestión operativa de ventas, clientes, productos y categorías de la cadena tecnológica **TechStore**.

---

## Arquitectura del Modelo (3NF)

El esquema está dividido en **3 tablas de dimensión** y **1 tabla de hechos**, garantizando integridad referencial y cero redundancia de datos:

* **`categorias`** *(Dimensión)*: Clasificación de familias de productos (`id_categoria` PK, `nombre_categoria`, `descripcion`).
* **`clientes`** *(Dimensión)*: Maestro de compradores (`id_cliente` PK, `nombre`, `email` UNIQUE, `ciudad`, `fecha_registro`).
* **`productos`** *(Dimensión)*: Catálogo comercial con control de stock y estado (`id_producto` PK, `nombre_producto`, `id_categoria` FK, `precio`, `stock`, `activo`).
* **`ventas`** *(Hechos)*: Registro transaccional central (`id_venta` PK, `id_cliente` FK, `id_producto` FK, `cantidad`, `precio_unitario`, `fecha_venta`).

```text
categorias (1) ──── (N) productos (1) ──── (N) ventas (N) ──── (1) clientes
