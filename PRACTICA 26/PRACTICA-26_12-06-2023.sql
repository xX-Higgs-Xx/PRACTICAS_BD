create database practica;
use practica;

create table clientes (
id_cliente integer auto_increment,
nombre varchar(255) not null,
correo varchar(255) not null,
credito float not null,

primary key (id_cliente)
);

create table pedidos (
id_pedidos integer auto_increment,
fk_cliente integer not null,
monto float not null,

primary key(id_pedidos),
foreign key(fk_cliente) references clientes(id_cliente)
);

INSERT INTO CLIENTES VALUES (1,'Jared Juarez','jaredjuarez@gmail.com',500);

INSERT INTO PEDIDOS VALUES (1,1,200);
INSERT INTO PEDIDOS VALUES (2,1,100);
INSERT INTO PEDIDOS VALUES (3,1,100);
INSERT INTO PEDIDOS VALUES (4,1,100);
INSERT INTO PEDIDOS VALUES (5,1,200);
#select * from clientes;

/*Paso 2: Crear un disparador 'BEFORE UPDATE' para la tabla
'clientes'
Crearemos un disparador que verifique si el nuevo límite de crédito es menor que el
monto total de los pedidos pendientes del cliente antes de actualizar el registro.*/
DELIMITER $$
  CREATE TRIGGER validar_limite_credito BEFORE UPDATE ON clientes
  FOR EACH ROW
  BEGIN
	DECLARE cred float;
	DECLARE gasto float;
    SET cred= NEW.credito;
    SELECT SUM(monto) into gasto from pedidos;
    IF cred<gasto THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '=== AUMENTE SU CREDITO ===';
    END IF;
END;$$

/*Paso 3: Probar el disparador 'BEFORE UPDATE'
Intente actualizar el límite de crédito de un cliente a un valor menor que el monto
total de sus pedidos pendientes y verifique si el disparador funciona correctamente:
Si el nuevo límite de crédito es menor que el monto total de pedidos pendientes,
debería recibir un error.*/
UPDATE clientes SET credito = 580 where id_cliente = 1;

/*Paso 4: Crear un disparador 'AFTER UPDATE' para la tabla 'clientes'
Crearemos un disparador que registre la fecha y hora de la última actualización del
límite de crédito en una nueva columna 'ultima_actualizacion'.
Primero, agregue la columna 'ultima_actualizacion' a la tabla 'clientes':*/
ALTER TABLE clientes ADD ultima_actualizacion DATE;

DELIMITER $$
CREATE TRIGGER fecha_actualizacion AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
	DECLARE act DATE;
    SELECT now() INTO act;
    UPDATE clientes SET ultima_actualizacion = act;
END;$$
#DROP TRIGGER fecha_actualizacion;

/*Paso 5: Probar el disparador 'AFTER UPDATE'
Actualice el límite de crédito de un cliente y verifique si la columna
'ultima_actualizacion' se actualiza correctamente.*/
UPDATE clientes SET credito = 1000 where id_cliente = 1;