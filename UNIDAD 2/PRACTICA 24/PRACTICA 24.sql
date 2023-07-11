create database practica24;
use practica24;

create table clientes (
id_cliente integer auto_increment,
nombre varchar(255) not null,
apellido varchar(255) not null,
saldo float not null,

primary key (id_cliente)
);

create table ventas (
id_ventas integer auto_increment,
fk_cliente integer not null,
producto varchar(255) not null,
monto float not null,

primary key(id_ventas),
foreign key(fk_cliente) references clientes(id_cliente)
);
INSERT INTO CLIENTES VALUES (1,'Jared','Juarez',200.5);
INSERT INTO CLIENTES VALUES (2,'Alberto','Perez',95.5);
INSERT INTO CLIENTES VALUES (3,'Carlos','Estrada',350.0);
INSERT INTO CLIENTES VALUES (4,'Jane','Austen',130.5);
INSERT INTO CLIENTES VALUES (5,'Alfred','Ruiz',420.0);

INSERT INTO VENTAS VALUES (1,1,'Papas',45.5);
INSERT INTO VENTAS VALUES (2,2,'Tequila',400.0);
INSERT INTO VENTAS VALUES (3,3,'Celular',2200.5);
INSERT INTO VENTAS VALUES (4,4,'Refresco',22.0);
INSERT INTO VENTAS VALUES (5,5,'Perfume',300.5);

/*Crearemos un disparador que verifique si el cliente tiene suficiente saldo antes de
insertar una nueva venta.*/

DELIMITER $$
  CREATE TRIGGER validar BEFORE INSERT ON ventas
  FOR EACH ROW
  BEGIN
	DECLARE monto_v float;
	DECLARE saldo_c float;
    SET monto_v= NEW.monto;
    SELECT saldo into saldo_c from clientes WHERE id_cliente=new.FK_cliente;
    IF monto_v <= 0 OR saldo_c < monto_v THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = ' saldo insuficiente.';
    END IF;
  END;$$

INSERT INTO VENTAS VALUES (6,1,'ALGO',500.2);

DELIMITER $$
CREATE TRIGGER actualizar_saldo AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
	DECLARE saldo_c float;
    SELECT saldo into saldo_c from clientes where id_cliente=new.fk_cliente;
    UPDATE clientes SET saldo = saldo_c - NEW.monto WHERE id_cliente = NEW.fk_cliente;
END;$$

INSERT INTO VENTAS VALUES(8,2,'OTRO',25);

SELECT * FROM CLIENTES;


