CREATE TABLE ALUMNOS(
    id_alumno NUMBER PRIMARY KEY,
    nombre_alumno VARCHAR(255),
    apellido VARCHAR(255),
    fk_curso NUMBER
);

CREATE TABLE CURSOS(
    id_curso NUMBER PRIMARY KEY,
    nombre_curso VARCHAR(255),
    profesor VARCHAR(255),
    horario_hrs NUMBER
);

INSERT INTO ALUMNOS VALUES (1,'Jared','Juarez',1);
INSERT INTO ALUMNOS VALUES (2,'Jose','Martinez',2);
INSERT INTO ALUMNOS VALUES (3,'Maria','Magdalena',3);
INSERT INTO ALUMNOS VALUES (4,'Lucia','Peralta',4);
INSERT INTO ALUMNOS VALUES (5,'Alberto','Leyva',5);

INSERT INTO CURSOS VALUES (1,'Matematicas','Luis Alberto',3);
INSERT INTO CURSOS VALUES (2,'Español','Jose Trujillo',4);
INSERT INTO CURSOS VALUES (3,'Ciencias','Enrrique Perez',5);
INSERT INTO CURSOS VALUES (4,'Historia','John Doe',5);
INSERT INTO CURSOS VALUES (5,'Filosofia','John Doe',2);

--Paso 2: Crear una vista
--Crea una vista llamada 'vista_alumnos_cursos' que muestre la información
--combinada de ambas tablas.
CREATE VIEW vista_alumnos_cursos AS
SELECT
    alumnos.id_alumno,
    alumnos.nombre_alumno,
    alumnos.apellido,
    alumnos.fk_curso,

    cursos.id_curso,
    cursos.nombre_curso,
    cursos.profesor,
    cursos.horario_hrs
FROM ALUMNOS INNER JOIN CURSOS ON ALUMNOS.FK_CURSO = CURSOS.ID_CURSO;

--Paso 3: Consultar la vista
--Realice una consulta en la vista creada, por ejemplo, para listar a los alumnos que
--están en cursos impartidos por el profesor "John Doe":
SELECT * FROM VISTA_ALUMNOS_CURSOS WHERE profesor='John Doe';

--Paso 4: EXPLAIN PLAN
--Ejecuta EXPLAIN PLAN en la consulta anterior para analizar el rendimiento.
EXPLAIN PLAN FOR SELECT * FROM VISTA_ALUMNOS_CURSOS;

--Paso 5: Revisar el resultado de EXPLAIN PLAN
--Utilice la siguiente consulta para revisar el resultado de EXPLAIN PLAN:
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());