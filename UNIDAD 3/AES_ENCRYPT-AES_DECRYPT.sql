create database prueba_encriptacion;
use prueba_encriptacion;

create table usuarios(
	id_usuario int primary key,
	password varbinary(256) not null,
    tarjeta varbinary(256) not null
);

# GENERAR LA LLAVE DE ENCRIPTACION
set @llave_password=sha2('$c0ntr4s3n4_p4ssw0rd',256);
set @llave_tarjeta=sha2('$c0ntr4s3n4',256);
select @key_str;

# ENCRIPTAR EL PASSWORD DE UN USUARIO
insert into usuarios(id_usuario, password,tarjeta) values (1,aes_encrypt('hola123',@llave_password),aes_encrypt('123456789',@llave_tarjeta));
select * from usuarios;

# DESENCRIPTAR LA CONTRASEÑA DEL USUARIO
select 
	id_usuario, 
    cast(aes_decrypt(password,@llave_password) as char(50)) as password_decrypt, 
    cast(aes_decrypt(tarjeta,@llave_tarjeta) as char(50)) as tarjeta_decrypt 
from usuarios;