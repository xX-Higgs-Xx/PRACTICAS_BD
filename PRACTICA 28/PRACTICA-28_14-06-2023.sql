create database practica;
use practica;

/*Paso 1:
Crear las tablas y poblarlas con datos Crearemos las tablas 'clientes' y 'pedidos' con
los siguientes campos y relaciones:*/
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
Probar el disparador 'BEFORE DELETE' Intente eliminar un cliente que tenga
pedidos asociados y verifique si el disparador funciona correctamente:*/
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

/*Paso 5: 
Probar el disparador 'AFTER DELETE' Elimine un cliente que no tenga pedidos
asociados y verifique si se registra en la tabla 'clientes_eliminados'.*/
DELETE FROM clientes WHERE id_cliente=4;