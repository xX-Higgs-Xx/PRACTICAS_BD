create database TIENDA;
use TIENDA;

/*
Paso 1: Crear las tablas
Para esta práctica, usaremos dos tablas relacionadas: 'clientes' y 'pedidos'. 
Cada cliente puede tener varios pedidos, y cada pedido
*/
CREATE TABLE clientes (
id_cliente INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
telefono VARCHAR(20) NOT NULL
);
CREATE TABLE pedidos (
id_pedido INT PRIMARY KEY,
id_cliente INT NOT NULL,
fecha DATE NOT NULL,
total INT NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

/*
Paso 2: Insertar datos
Inserta datos de ejemplo en las tablas 'clientes' y 'pedidos':
*/
INSERT INTO clientes VALUES (1, 'Laura', 'laura@gmail.com', '555-1234');
INSERT INTO clientes VALUES (2, 'Miguel', 'miguel@gmail.com', '555-5678');
INSERT INTO clientes VALUES (3, 'Sofía', 'sofia@gmail.com', '555-9101');
INSERT INTO clientes VALUES (4, 'Daniel', 'daniel@gmail.com', '555-1121');
INSERT INTO clientes VALUES (5, 'Camila', 'camila@gmail.com', '555-3141');

INSERT INTO pedidos VALUES (1, 1, '2023-01-15', 100);
INSERT INTO pedidos VALUES (2, 2, '2023-02-10', 50);
INSERT INTO pedidos VALUES (3, 3, '2023-02-20', 75);
INSERT INTO pedidos VALUES (4, 4, '2023-03-05', 25);
INSERT INTO pedidos VALUES (5, 5, '2023-03-15', 150);

/*
Paso 3: Crear un procedimiento almacenado
Crea un procedimiento almacenado llamado 'mostrar_resumen_pedidos' que muestre 
la información de los clientes y sus pedidos.
*/

DELIMITER $$
CREATE PROCEDURE mostrar_resumen_pedidos (id_cliente_num int)
begin
	select * from clientes inner join pedidos on clientes.id_cliente = pedidos.id_cliente and clientes.id_cliente = id_cliente_num;
end;$$

call mostrar_resumen_pedidos (3);