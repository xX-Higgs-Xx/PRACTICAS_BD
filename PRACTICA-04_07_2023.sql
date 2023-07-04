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
    tabla varchar(50) not null,
    accion varchar(50) not null,
    fecha datetime not null,
    datos_new varchar(255),
    datos_old varchar(255)
);

#Tabla para guardar productos
create table categorias(
	id_categorias int auto_increment primary key,
    nombre varchar(255) not null
);

#Creacion de inidices
create index idx_clientes_nombre on clientes(nombre);

#Creacion de vistas
create view v_info_clientes as
	select nombre,email from clientes;
#Disparadores
    drop trigger log_clientes_insert;
    
DELIMITER $$
create trigger log_clientes_insert after insert on clientes
for each row
begin
	declare datos_new varchar(255);
    set datos_new= concat('id: ',new.id_cliente,' nombre:',new.nombre,' email:',new.email,' edad:',new.edad);
	insert into log (tabla, accion, fecha, datos_new)
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
		insert into clientes(nombre,email,edad) values (_nombre,_email,_edad);
        select * from log where tabla = 'clientes' and accion='insert' order by fecha;
    end if;
    set autocommit = 1;
end;$$

call insertar_cliente('Jared','jared@utez.edu',20);



#ACTUALIZAR
DELIMITER $$
create procedure actualizar_cliente
	(id int, nombre_new varchar(255), correo_new varchar(255), edad_new int)
begin
	set autocommit=0;
    start transaction;
    #Conjunto de operaciones
    
    #Bloquear el registro a actualizar (ACTUALIZAR/ELIMINAR)
    select * from clientes where id_cliente=id for update;
    #Validar si el registro existe en la base de datos
    if exists(select * from clientes where id_cliente=id) then
		#Actualizar
        update clientes
			set nombre=nombre_new,
				email=email_new,
                edad=edad_new
			where id_cliente=id;
            commit;
            select * from log where tabla='clientes' and accion='update' order by fecha desc limit 1;
	else
		#Error
        select 'EL usuario a actualizar no existe' as mensaje;
	end if;
    set autocommit=1;
end;$$
call actualizar_cliente(10,'jared','jared@utez.com',20);
#ELIMIAR

#CONSULTAR
create procedure consultar_log(tabla_consulta varchar(255), id_consulta varchar(255))
begin
	declare query_ varchar(255);
    set query_ = concat('%id: ', id_consulta,'%')
	set autocommit = 0;
    start transaction;
		if tabla consulta = '' then
			select * from log order by tabla, fecha desc;
		else
			if id_consulta='' then
				select * from log where tabla=tabla_consulta order by fecha desc;
			else
				select * from log
			end if;
		end if;
end;$$

 
DELIMITER $$
create trigger log_categorias_insert after insert on categorias
for each row
begin
	declare datos_new varchar(255);
    set datos_new= concat('id: ',new.id_categorias,' nombre: ',new.nombre);
	insert into log (tabla, accion, fecha, datos_new)
		values ('categorias','insert',sysdate(),datos_new);
end;$$

DELIMITER $$
create trigger log_categorias_update after update on categorias
for each row
begin
	declare datos_new varchar(255);
	declare datos_old varchar(255);
    set datos_new= concat('id: ',new.id_categorias,' nombre: ',new.nombre);
    set datos_old= concat('id: ',old.id_categorias,' nombre: ',old.nombre);
	insert into log(tabla, accion, fecha, datos_new,datos_old)
		values ('categorias','update',sysdate(),datos_new,datos_old);
end;$$

DELIMITER $$
create trigger log_categorias_delete after delete on categorias
for each row
begin
	declare datos_old varchar(255);
    set datos_old= concat('id: ',old.id_categorias,' nombre: ',old.nombre);
	insert into log(tabla, accion, fecha, datos_old)
		values ('categorias','delete',sysdate(),datos_old);
end;$$

#'Ropa,Electronicos,Joyeria'
DELIMITER $$
create procedure carga_categorias(cadena text)
begin
	declare posicion int default 1;
    declare longitud int default length(cadena);
    declare categoria varchar(255);
    
    while(posicion <= longitud) do
		set categoria = substring_index2(substring_index2(cadena,',',posicion),',',-1);
        insert into categorias(nombre) values (categoria);
        set posicion=posicion+1;
    end while;
    set autocommit = 0;
    start transaction;
    
    
    set autocommit = 1;
end;$$