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

---

## Consultas Analíticas de Negocio (`m4_consultas_negocio.sql`)

Extracción de métricas comerciales clave sobre la tabla transaccional `ventas` para la toma de decisiones ejecutivas:

1. **Resumen Ejecutivo Mensual:** Cálculo de facturación total (`$6.444,00`), volumen de pedidos (`10`) y ticket promedio (`$644,40`) agrupados por mes.
2. **Ranking Top 5 de Productos:** Ordenamiento por ingresos generados vs. unidades vendidas para detectar productos estrella y artículos de alta rotación pero bajo margen.
3. **Análisis de Recurrencia:** Identificación de clientes con más de un pedido (`HAVING COUNT(*) > 1`), evidenciando un 100% de recompra en la cartera activa.
4. **Clasificación por Rendimiento (CTE + Subconsulta):** Uso de expresiones de tabla común (`WITH`) y lógica condicional (`CASE WHEN`) para segmentar productos por encima o por debajo de la facturación media por artículo (`$1.074,00`).

### Principales Hallazgos
* **Concentración Pareto:** El Producto 1 (*Laptop Pro 15*) concentra el **55,8%** de la facturación mensual (`$3.600,00`) con apenas 3 unidades vendidas.
* **Brecha Volumen vs. Ingreso:** El Producto 2 (*Mouse Inalámbrico*) lidera en cantidad (`13 unidades`), pero aporta solo el **5,6%** de los ingresos (`$364,00`).
* **Competencia en el Top 5:** El Producto 4 (*Auriculares BT Pro*) quedó fuera del ranking principal por apenas `$4,00` de diferencia (`$360,00` vs. `$364,00`).
