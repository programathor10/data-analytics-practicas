# Gestión de Inventario - BodegaTech

Este repositorio contiene el script SQL correspondiente a la práctica del **Módulo 3**, enfocado en la creación, carga y actualización segura de una base de datos de inventario para **BodegaTech**.

## 📋 Descripción del Proyecto

El script `BodegaTech_inventario.sql` abarca el ciclo completo de operaciones fundamentales en SQL (DDL y DML):

* **Definición de Estructura (DDL):** Creación de la tabla `inventario` con idempotencia (`DROP TABLE IF EXISTS`), definición de clave primaria autoincremental (`IDENTITY`), restricciones de nulidad (`NOT NULL`) y tipos de datos optimizados según la lógica de negocio (`DECIMAL` para precios, `INT` para cantidades enteras, `DATE` para fechas de ingreso y `TINYINT` para estados lógicos).
* **Carga de Datos (DML - INSERT):** Inserción inicial de 10 productos tecnológicos distribuidos en distintas categorías (*Computación*, *Accesorios*, *Audio* y *Almacenamiento*).
* **Actualización de Registros (DML - UPDATE):** Modificaciones quirúrgicas sobre el stock y estado de productos específicos utilizando la cláusula `WHERE` para garantizar la integridad de los datos y evitar modificaciones masivas accidentales.

## 🛠️ Requisitos

* **Motor de Base de Datos:** Microsoft SQL Server.
* **Cliente recomendado:** SQL Server Management Studio (SSMS) o Azure Data Studio.

## 🚀 Instrucciones de Ejecución

1. Descarga o clona este repositorio en tu equipo local.
2. Abre **SQL Server Management Studio (SSMS)** y conéctate a tu instancia local o servidor de pruebas.
3. Selecciona o crea una base de datos de trabajo donde desees alojar la tabla.
4. Abre el archivo `BodegaTech_inventario.sql`.
5. Ejecuta el script completo presionando **F5** (o el botón **Execute**), o bien selecciona y ejecuta cada bloque (`DDL` y `DML`) de manera secuencial para observar los resultados paso a paso.
