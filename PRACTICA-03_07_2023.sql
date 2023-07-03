create database CRUD;
use CRUD;

#Crear una tabla clientes
create table clientes(
id_cliente integer auto_increment primary key,
nombre varchar(50) not null,
email varchar(50),
edad int not null
);

create table log(
	id_log int auto_increment primary key,
    tabal varchar(50) not null,
    accion varchar(50) not null,
    fecha datetime not null,
    datos_new varchar(255),
    datos_old varchar(255)
);

#Creacion de inidices
create index idx_clientes_nombre on clientes(nombre);

#Creacion de vistas
create view v_info_clientes as
	select nombre,email from clientes;
    
#Disparadores
DELIMITER $$
create trigger log_clientes_insert after insert on clientes
for each row
begin
	declare datos_new varchar(255);
    set datos_new= concat('id',new.id_cliente,' nombre:',new.nombre,' edad:',new.edad,' email:',new.email);
	insert into log(tabla, accion, fecha, datos_new)
		values ('clientes','insert',sysdate(),datos_new);
end;$$
DELIMITER $$
create trigger log_clientes_update after update on clientes
for each row
begin
	declare datos_new varchar(255);
	declare datos_old varchar(255);
    set datos_new= concat('id',new.id_cliente,' nombre:',new.nombre,' edad:',new.edad,' email:',new.email);
    set datos_old= concat('id',old.id_cliente,' nombre:',old.nombre,' edad:',old.edad,' email:',old.email);
	insert into log(tabla, accion, fecha, datos_new,datos_old)
		values ('clientes','update',sysdate(),datos_new,datos_old);
end;$$
drop trigger log_clientes_delete;
DELIMITER $$
create trigger log_clientes_delete after delete on clientes
for each row
begin
	declare datos_old varchar(255);
    set datos_old= concat('id',old.id_cliente,' nombre:',old.nombre,' edad:',old.edad,' email:',old.email);
	insert into log(tabla, accion, fecha, datos_old)
		values ('clientes','delete',sysdate(),datos_old);
end;$$

#INSERTAR
DELIMITER $$
create procedure insertar_cliente (_nombre varchar(50), _email varchar(50), _edad int)
begin
 set autocommit = 0;
 start transaction;
	#Todas la acciones de la trasaccion
    #Validar que no exista un registro con la misma informacion
    if exists(select * from clientes where nombre=_nombre and email=_email and edad=_edad) then
		select 'Ya existe un registro con esa informacion' as mensaje;
        rollback;
    else
		insert into clientes(nombre,edad,email) values (_nombre,_email,_edad);
        select * from log where tabla = 'clientes' and accion='insert' order by fecha;
    end if;
    set autocommit = 1;
end;$$

call insertar_cliente ('Jared','jared@utez.edu',20);
call insertar_cliente('Jared','jared@utez.edu',20);

#ACTUALIZAR
#ELIMIAR
#CONSULTAR