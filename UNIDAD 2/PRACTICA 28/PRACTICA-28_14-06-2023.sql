create database practica;
use practica;

create table clientes (
id_cliente integer auto_increment,
nombre varchar(255) not null,
email varchar(255) not null,
telefono integer not null,

primary key (id_cliente)
);

create table pedidos (
id_pedidos integer auto_increment,
fk_cliente integer not null,
fecha date,
total integer not null,

primary key(id_pedidos),
foreign key(fk_cliente) references clientes(id_cliente)
);

INSERT INTO CLIENTES VALUES (1,'Jared Juarez','jaredjuarez@gmail.com',4997726);
INSERT INTO CLIENTES VALUES (4,'Arturo','arturo@gmail.com',8888888);

INSERT INTO PEDIDOS VALUES (1,1,("2023-06-15"),1200);	
INSERT INTO PEDIDOS VALUES (2,1,("2023-07-25"),2400);
INSERT INTO PEDIDOS VALUES (3,1, ("2023-08-18"),300);
INSERT INTO PEDIDOS VALUES (4,1, ("2023-09-15"),450);
INSERT INTO PEDIDOS VALUES (5,1, ("2023-10-08"),200);
#select * from clientes;

/*Paso 2:
Crear un disparador 'BEFORE DELETE' para la tabla 'clientes' Crearemos un
disparador que verifique si un cliente tiene pedidos asociados antes de eliminarlo.*/
DELIMITER $$
  CREATE TRIGGER validar_antes_eliminar BEFORE DELETE ON clientes
  FOR EACH ROW
  BEGIN
	DECLARE pedidos_cont integer;
    
    SELECT count(*) into pedidos_cont from pedidos where fk_cliente = OLD.id_cliente;
    IF pedidos_cont > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '=== NO SE PUEDE ELIMINAR EL CLIENTE, TIENE PEDIDOS ASOCIADOS ===';
    END IF;
END;$$

/*PASO 3:
Crear un disparador 'BEFORE DELETE' para la tabla 'clientes' Crearemos un
disparador que verifique si un cliente tiene pedidos asociados antes de eliminarlo.*/
DELETE FROM clientes WHERE id_cliente=1;

/*Paso 4:
Crear un disparador 'AFTER DELETE' para la tabla 'clientes' Crearemos un
disparador que registre la eliminación de un cliente en una tabla de auditoría
llamada 'clientes_eliminados'.*/
CREATE TABLE clientes_eliminados (
	id_cliente_eliminado integer auto_increment,
    id_cliente integer not null,
    nombre varchar(255) not null,
	email varchar(255) not null,
	telefono integer not null,
    fecha_eliminacion date,
    
	primary key(id_cliente_eliminado)
);
DELIMITER $$

CREATE TRIGGER registrar_eliminados AFTER DELETE ON clientes
FOR EACH ROW
BEGIN
	insert into clientes_eliminados(id_cliente,nombre,email,telefono,fecha_eliminacion) 
    value (old.id_cliente , old.nombre , old.email , old.telefono , sysdate());
END;$$

select * from clientes_eliminados;
DROP TRIGGER registrar_eliminados;

/*Paso 5: Probar el disparador 'AFTER UPDATE'
Actualice el límite de crédito de un cliente y verifique si la columna
'ultima_actualizacion' se actualiza correctamente.*/
UPDATE clientes SET credito = 1000 where id_cliente = 1;