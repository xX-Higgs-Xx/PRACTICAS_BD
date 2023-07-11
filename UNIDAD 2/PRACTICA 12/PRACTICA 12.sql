--JARED ADRIÁN JUÁREZ BERNAL   3°D-DSM

--Paso 1: Crear la base de dato
--Primero, crearemos dos tablas: 'libros' y 'prestamos'. La tabla 'libros' tendrá 3
--atributos (id, titulo, genero) y la tabla 'prestamos' tendrá 4 atributos (id, libro_id,
--fecha_prestamo, usuario). A continuación, insertaremos 5 registros en cada tabla.
CREATE TABLE libros (
id NUMBER PRIMARY KEY,
titulo VARCHAR2(100),
genero VARCHAR2(100)
);
INSERT INTO libros (id, titulo, genero) VALUES (1, 'La Odisea', 'Epopeya');
INSERT INTO libros (id, titulo, genero) VALUES (2, 'Don Quijote de la Mancha', 'Novela');
INSERT INTO libros (id, titulo, genero) VALUES (3, 'Cien años de soledad', 'Novela');
INSERT INTO libros (id, titulo, genero) VALUES (4, 'Hamlet', 'Tragedia');
INSERT INTO libros (id, titulo, genero) VALUES (5, 'El Principito', 'Cuento');
CREATE TABLE prestamos (
id NUMBER PRIMARY KEY,
libro_id NUMBER,
fecha_prestamo DATE,
usuario VARCHAR2(100),
FOREIGN KEY (libro_id) REFERENCES libros (id)
);
INSERT INTO prestamos (id, libro_id, fecha_prestamo, usuario) VALUES (1, 1, DATE '2023-01-01', 'Ana');
INSERT INTO prestamos (id, libro_id, fecha_prestamo, usuario) VALUES (2, 2, DATE '2023-01-01', 'Luis');
INSERT INTO prestamos (id, libro_id, fecha_prestamo, usuario) VALUES (3, 3, DATE '2023-01-02', 'Sofía');
INSERT INTO prestamos (id, libro_id, fecha_prestamo, usuario) VALUES (4, 4, DATE '2023-01-02', 'Miguel');
INSERT INTO prestamos (id, libro_id, fecha_prestamo, usuario) VALUES (5, 5, DATE '2023-01-03', 'Carla');

--Paso 2: GROUP BY
--Ahora, utilizaremos GROUP BY para agrupar los préstamos por 'genero' y 'usuario'
--y calcular el total de préstamos para cada grupo.
SELECT 
    genero,
    usuario, 
    count(*) AS PRESTAMOS     
FROM LIBROS,PRESTAMOS WHERE libros.id=prestamos.id GROUP BY genero,usuario;

--Paso 3: HAVING
--A continuación, utilizaremos HAVING para filtrar los resultados del paso anterior y
--mostrar solo aquellos grupos cuyo total de préstamos es mayor a 1.
SELECT 
    genero,
    usuario, 
    count(genero) AS PRESTAMOS     
FROM LIBROS,PRESTAMOS WHERE libros.id=prestamos.id GROUP BY genero,usuario HAVING count(genero)>2;