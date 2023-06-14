--Jared Adrián Juárez Bernal     3°D - DSM

--Paso 1: Crear la base de datos
--Primero, crearemos una base de datos simple con una tabla llamada 'ventas', la
--cual tendrá 4 atributos (id, vendedor_id, cantidad_vendida, precio_unitario). A
--continuación, insertaremos 5 registros en la tabla.
CREATE TABLE ventas (
id NUMBER PRIMARY KEY,
vendedor_id NUMBER,
cantidad_vendida NUMBER,
precio_unitario NUMBER
);
INSERT INTO ventas (id, vendedor_id, cantidad_vendida, precio_unitario) VALUES (1, 1,5, 100);
INSERT INTO ventas (id, vendedor_id, cantidad_vendida, precio_unitario) VALUES (2, 1,10, 50);
INSERT INTO ventas (id, vendedor_id, cantidad_vendida, precio_unitario) VALUES (3, 2,8, 75);
INSERT INTO ventas (id, vendedor_id, cantidad_vendida, precio_unitario) VALUES (4, 2,15, 25);
INSERT INTO ventas (id, vendedor_id, cantidad_vendida, precio_unitario) VALUES (5, 3,20, 10);

--Paso 2: SUM, AVG, MIN, MAX y COUNT
--Ahora, vamos a aplicar las funciones de agregación en Oracle SQL para calcular el
--total de ventas, el promedio, el mínimo, el máximo y la cantidad de registros en la
--tabla 'ventas'.
SELECT SUM(cantidad_vendida*precio_unitario) AS TOTAL_VENTAS, AVG(cantidad_vendida*precio_unitario) AS PROMEDIO, MIN(cantidad_vendida*precio_unitario) AS MINIMO, MAX(cantidad_vendida*precio_unitario) AS MAXIMO, COUNT(*) AS CANTIDAD_REGISTROS FROM VENTAS;