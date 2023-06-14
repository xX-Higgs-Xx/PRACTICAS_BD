CREATE TABLE autores (
id_autor NUMBER PRIMARY KEY,
nombre VARCHAR2(100),
nacionalidad VARCHAR2(50)
);
INSERT INTO autores VALUES (1, 'Gabriel García Márquez', 'Colombiano');
INSERT INTO autores VALUES (2, 'Isabel Allende', 'Chilena');
INSERT INTO autores VALUES (3, 'Carlos Ruiz Zafón', 'Español');
INSERT INTO autores VALUES (4, 'Ernest Hemingway', 'Estadounidense');
INSERT INTO autores VALUES (5, 'Jane Austen', 'Inglesa');

CREATE TABLE libros (
id_libro NUMBER PRIMARY KEY,
titulo VARCHAR2(100),
fk_autor NUMBER,
fecha_publicacion DATE,
precio NUMBER
);
INSERT INTO libros VALUES (1, 'Cien años de soledad', 1, TO_DATE('1967-06-05', 'YYYY-MM-DD'), 14.99);
INSERT INTO libros VALUES (2, 'La casa de los espíritus', 2, TO_DATE('1982-01-01', 'YYYY-MM-DD'), 10.99);
INSERT INTO libros VALUES (3, 'La sombra del viento', 3, TO_DATE('2001-01-01', 'YYYY-MM-DD'), 12.99);
INSERT INTO libros VALUES (4, 'El viejo y el mar', 4, TO_DATE('1952-09-01', 'YYYY-MM-DD'), 7.99);
INSERT INTO libros VALUES (5, 'Orgullo y prejuicio', 5, TO_DATE('1813-01-28', 'YYYY-MM-DD'), 9.99);

--Paso 2: Crear la vista
--A continuación, crearemos una vista llamada 'vista_libros_autores' que combinará
--información de ambas tablas:
CREATE VIEW vista_libros_autores AS 
SELECT 
    autores.id_autor,
    autores.nombre,
    autores.nacionalidad,
    
    libros.id_libro,
    libros.titulo,
    libros.fk_autor,
    libros.fecha_publicacion,
    libros.precio
FROM autores INNER JOIN libros 
ON autores.id_autor = libros.fk_autor;

--Paso 3: EXPLAIN PLAN
--Realizaremos una consulta en la vista 'vista_libros_autores' para obtener todos los
--libros de autores de nacionalidad 'Colombiano', además utiliza EXPLAIN PLAN para
--analizar el rendimiento de la consulta.
SELECT * FROM vista_libros_autores WHERE nacionalidad='Colombiano';

--Paso 4: Analizar el plan de ejecución
--Después de ejecutar EXPLAIN PLAN, revisaremos el plan de ejecución generado
--utilizando la siguiente consulta.
EXPLAIN PLAN FOR SELECT * FROM vista_libros_autores;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

--Paso 5: Crear índices y volver a ejecutar EXPLAIN PLAN
--Agregar un índice en la columna 'nacionalidad' de la tabla 'autores':
--Una vez que haya realizado los cambios, vuelva a ejecutar EXPLAIN PLAN para la
--consulta.
CREATE INDEX idx_autores_nacionalidad ON autores(nacionalidad);
EXPLAIN PLAN FOR SELECT * FROM vista_libros_autores;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
