--JARED ADRIÁN JUÁREZ BERNAL   3°D-DSM

--Paso 1: Crear la base de dato
--Primero, crearemos dos tablas: 'tiendas' y 'productos'. La tabla 'tiendas' tendrá 3
--atributos (id, nombre, ubicacion) y la tabla 'productos' tendrá 4 atributos (id,
--tienda_id, nombre, precio). A continuación, insertaremos 5 registros en cada tabla.
CREATE TABLE tiendas (
id NUMBER PRIMARY KEY,
nombre VARCHAR2(100),
ubicacion VARCHAR2(100)
);
INSERT INTO tiendas (id, nombre, ubicacion) VALUES (1, 'Supermercado A', 'Centro');
INSERT INTO tiendas (id, nombre, ubicacion) VALUES (2, 'Supermercado B', 'Norte');
INSERT INTO tiendas (id, nombre, ubicacion) VALUES (3, 'Supermercado C', 'Sur');
INSERT INTO tiendas (id, nombre, ubicacion) VALUES (4, 'Supermercado D', 'Este');
INSERT INTO tiendas (id, nombre, ubicacion) VALUES (5, 'Supermercado E', 'Oeste');
CREATE TABLE productos (
id NUMBER PRIMARY KEY,
tienda_id NUMBER,
nombre VARCHAR2(100),
precio NUMBER,
FOREIGN KEY (tienda_id) REFERENCES tiendas (id)
);
INSERT INTO productos (id, tienda_id, nombre, precio) VALUES (1, 1, 'Manzanas', 1.5);
INSERT INTO productos (id, tienda_id, nombre, precio) VALUES (2, 2, 'Plátanos', 0.8);
INSERT INTO productos (id, tienda_id, nombre, precio) VALUES (3, 3, 'Naranjas', 1.2);
INSERT INTO productos (id, tienda_id, nombre, precio) VALUES (4, 4, 'Peras', 1.7);
INSERT INTO productos (id, tienda_id, nombre, precio) VALUES (5, 5, 'Uvas', 2.5);

--Paso 2: ORDER BY
--Ahora, realizaremos una consulta que muestre el nombre de la tienda, la ubicación
--de la tienda, el nombre del producto y su precio, ordenando los resultados por la
--ubicación de la tienda y el precio del producto de forma ascendente.
SELECT
    TIENDAS.NOMBRE AS TIENDA,
    TIENDAS.UBICACION AS UBICACION,
    PRODUCTOS.NOMBRE AS PRODUCTO,
    PRODUCTOS.PRECIO AS PRECIO
FROM TIENDAS, PRODUCTOS WHERE PRODUCTOS.TIENDA_ID=TIENDAS.ID 
ORDER BY TIENDAS.UBICACION, PRODUCTOS.PRECIO ASC;