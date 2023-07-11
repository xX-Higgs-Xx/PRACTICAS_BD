--JARED ADRIÁN JUÁREZ BERNAL   3°D-DSM

--Paso 1: Crear la base de datos
--Primero, crearemos dos tablas: 'productos' y 'ventas'. La tabla 'productos' tendrá 3
--atributos (id, nombre, categoria) y la tabla 'ventas' tendrá 4 atributos (id,
--producto_id, fecha, cantidad). A continuación, insertaremos 5 registros en cada
--tabla.
CREATE TABLE productos (
id NUMBER PRIMARY KEY,
nombre VARCHAR2(100),
categoria VARCHAR2(100)
);
INSERT INTO productos (id, nombre, categoria) VALUES (1, 'Manzana', 'Frutas');
INSERT INTO productos (id, nombre, categoria) VALUES (2, 'Pera', 'Frutas');
INSERT INTO productos (id, nombre, categoria) VALUES (3, 'Leche', 'Lácteos');
INSERT INTO productos (id, nombre, categoria) VALUES (4, 'Yogur', 'Lácteos');
INSERT INTO productos (id, nombre, categoria) VALUES (5, 'Pan', 'Panadería');
CREATE TABLE ventas (
id NUMBER PRIMARY KEY,
producto_id NUMBER,
fecha DATE,
cantidad NUMBER,
FOREIGN KEY (producto_id) REFERENCES productos (id)
);
INSERT INTO ventas (id, producto_id, fecha, cantidad) VALUES (1, 1, DATE '2023-01-01',10);
INSERT INTO ventas (id, producto_id, fecha, cantidad) VALUES (2, 2, DATE '2023-01-01',15);
INSERT INTO ventas (id, producto_id, fecha, cantidad) VALUES (3, 3, DATE '2023-01-02',20);
INSERT INTO ventas (id, producto_id, fecha, cantidad) VALUES (4, 4, DATE '2023-01-02',30);
INSERT INTO ventas (id, producto_id, fecha, cantidad) VALUES (5, 5, DATE '2023-01-03',25);

--Paso 2: GROUP BY
--Ahora, utilizaremos GROUP BY para agrupar las ventas por 'categoria' y 'fecha' y
--calcular el total de ventas para cada grupo.
SELECT 
    categoria, 
    fecha, 
    sum(cantidad) AS TOTAL_VENTAS 
FROM PRODUCTOS, VENTAS WHERE productos.id=ventas.id GROUP BY fecha,categoria;

--Paso 3: HAVING
--A continuación, utilizaremos HAVING para filtrar los resultados del paso anterior y
--mostrar solo aquellos grupos cuyo total de ventas es mayor a 20.
SELECT 
    categoria, 
    fecha, 
    sum(cantidad) AS TOTAL_VENTAS
FROM PRODUCTOS, VENTAS WHERE productos.id=ventas.id GROUP BY fecha,categoria HAVING sum(cantidad)>20;
