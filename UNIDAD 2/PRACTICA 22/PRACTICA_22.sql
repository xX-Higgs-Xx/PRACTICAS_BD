CREATE TABLE PACIENTES(
    id_paciente NUMBER PRIMARY KEY,
    nombre VARCHAR(255),
    fecha_nacimiento DATE,
    fk_medico NUMBER
);

CREATE TABLE MEDICOS(
    id_medico NUMBER PRIMARY KEY,
    nombre_medico VARCHAR(255),
    especialidad VARCHAR(255),
    experiencia_anios NUMBER
);

INSERT INTO PACIENTES VALUES (1,'Jared Juarez',TO_DATE('2002-12-19', 'YYYY-MM-DD'),1);
INSERT INTO PACIENTES VALUES (2,'Jose Martinez',TO_DATE('2000-05-22', 'YYYY-MM-DD'),2);
INSERT INTO PACIENTES VALUES (3,'Maria Magdalena',TO_DATE('2004-03-10', 'YYYY-MM-DD'),3);
INSERT INTO PACIENTES VALUES (4,'Lucia Peralta',TO_DATE('2002-11-19', 'YYYY-MM-DD'),4);
INSERT INTO PACIENTES VALUES (5,'Alberto Leyva',TO_DATE('2003-08-02', 'YYYY-MM-DD'),5);

INSERT INTO MEDICOS VALUES (1,'Luis Monrroy','Cardiología',10);
INSERT INTO MEDICOS VALUES (2,'Jose Trujillo','Cirugía Plástica',4);
INSERT INTO MEDICOS VALUES (3,'Enrrique Perez','Dermatología',7);
INSERT INTO MEDICOS VALUES (4,'Sofia Rodrigez','Neumología',8);
INSERT INTO MEDICOS VALUES (5,'Arturo Bernal','Cardiología',2);

--Paso 2: Crear una vista
--Crea una vista llamada 'vista_pacientes_medicos' que muestre la información
--combinada de ambas tablas:
CREATE VIEW vista_pacientes_medicos AS
SELECT
    pacientes.id_paciente,
    pacientes.nombre,
    pacientes.fecha_nacimiento,
    pacientes.fk_medico,

    medicos.id_medico,
    medicos.nombre_medico,
    medicos.especialidad,
    medicos.experiencia_anios
FROM PACIENTES INNER JOIN MEDICOS ON PACIENTES.FK_MEDICO = MEDICOS.ID_MEDICO;

--Paso 3: Consultar la vista
--Realice una consulta en la vista creada, por ejemplo, para listar a los pacientes
--atendidos por médicos con una experiencia de más de 5 años:
SELECT * FROM vista_pacientes_medicos WHERE EXPERIENCIA_ANIOS>5;

--Paso 4: EXPLAIN PLAN
--Ejecuta EXPLAIN PLAN en la consulta anterior para analizar el rendimiento:
EXPLAIN PLAN FOR SELECT * FROM vista_pacientes_medicos;

--Paso 5: Revisar el resultado de EXPLAIN PLAN
--Utilice la siguiente consulta para revisar el resultado de EXPLAIN PLAN:
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());

--Paso 6: Crear índices y volver a ejecutar EXPLAIN PLAN
--Agregar un índice en la columna 'experiencia' de la tabla 'medicos':
--Una vez que haya realizado los cambios, vuelva a ejecutar EXPLAIN PLAN para la
--consulta:
CREATE INDEX idx_experiencia_medicos ON medicos(experiencia_anios);