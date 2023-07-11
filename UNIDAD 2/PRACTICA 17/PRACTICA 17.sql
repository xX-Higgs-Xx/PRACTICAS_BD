--JARED ADRIÁN JUÁREZ BERNAL  3°D-DSM

--Paso 1: Crear la base de datos
--Primero, crearemos una tabla llamada 'pedidos' con 4 atributos (id, cliente_id, fecha,
--total) e insertaremos 10 registros en ella.

CREATE TABLE pedidos (
id NUMBER PRIMARY KEY,
cliente_id NUMBER,
fecha DATE,
total NUMBER(6,2)
);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (1, 1, DATE '2023-01-01', 100.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (2, 1, DATE '2023-01-02', 200.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (3, 2, DATE '2023-01-03', 300.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (4, 2, DATE '2023-01-04', 400.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (5, 1, DATE '2023-01-05', 500.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (6, 3, DATE '2023-01-06', 600.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (7, 3, DATE '2023-01-07', 700.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (8, 3, DATE '2023-01-08', 800.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (9, 4, DATE '2023-01-09', 900.00);
INSERT INTO pedidos (id, cliente_id, fecha, total) VALUES (10, 4, DATE '2023-01-10', 1000.00);
SELECT EXTRACT(MONTH FROM FECHA) FROM PEDIDOS;
--Paso 2: Crear un índice compuesto
--A continuación, crearemos un índice compuesto en las columnas 'cliente_id' y
--'fecha' de la tabla 'pedidos'.
CREATE INDEX idx_cliente_fecha ON PEDIDOS(CLIENTE_ID,FECHA);

--Paso 3: EXPLAIN PLAN
--Ahora, realizaremos una consulta que busque todos los pedidos del cliente con ID 1
--realizados en enero de 2023 utilizando EXPLAIN PLAN para analizar el rendimiento
--de la consulta.
EXPLAIN PLAN FOR SELECT * FROM PEDIDOS WHERE CLIENTE_ID=1 AND EXTRACT(MONTH FROM FECHA)=1;

--Paso 4: Consultar el plan de ejecución
--Finalmente, consultaremos el plan de ejecución utilizando la vista 'PLAN_TABLE'
--para verificar si el índice 'idx_cliente_fecha' se está utilizando.
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());