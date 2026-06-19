-- SE CREAN LAS TABLAS:

CREATE TABLE trabajador (
	legajo INT PRIMARY KEY,
	nombre VARCHAR(12),
	tarifa INT,
	oficio VARCHAR(12)
);

CREATE TABLE edificio (
	id_e INT PRIMARY KEY,
	dir VARCHAR(20),
	tipo VARCHAR(10),
	nivel_calidad INT,
	categoria INT
);

CREATE TABLE asignacion (
	legajo INT,
	id_e INT,
	fecha_inicio TIMESTAMP,
	num_dias INT,
	CONSTRAINT fk_legajo FOREIGN KEY (legajo) REFERENCES trabajador(legajo),
	CONSTRAINT fk_id_e FOREIGN KEY (id_e) REFERENCES edificio(id_e)
);

-- SE INSERTAN DATOS EN LAS TABLAS CREADAS:

ALTER TABLE trabajador ADD legajo_supv INT NULL REFERENCES trabajador;

INSERT INTO trabajador (legajo, nombre, tarifa, oficio, legajo_supv)
VALUES (1235, 'M. Fernandez', 12.5, 'electricista', 1311),
 	   (1311, 'C. Garcia', 15.5, 'electricista', 1311),
 	   (1412, 'C. Gonzalez', 13.75, 'plomero', 1520),
 	   (1520, 'H. Caballero', 11.75, 'plomero', 1520),
 	   (2920, 'R. Perez', 10.0, 'albanhil', 2920),
 	   (3001, 'J. Gutierrez', 8.2, 'carpintero', 3231),
 	   (3231, 'P. Alvarez', 17.4, 'carpintero', 3231);


INSERT INTO edificio (id_e, dir, tipo, nivel_calidad, categoria)
VALUES (111, 'Av. Paseo Colon 1213', 'oficina', 4, 1),
	   (210, 'Rivadavia 1011', 'oficina', 3, 1),
	   (312, 'Tucuman 123', 'oficina', 2, 2),
	   (435, 'Cabildo 456', 'comercio', 1, 1),
	   (460, 'Santa Fe 1415', 'almacen', 3, 3),
	   (515, 'Chile 789', 'residencia', 3, 2);

INSERT INTO asignacion (legajo, id_e, fecha_inicio, num_dias)
VALUES (1235, 312, '2014-10-10 00:00:00', 5),
	   (1235, 515, '2014-10-17 00:00:00', 22),
	   (1311, 435, '2014-10-08 00:00:00', 12),
	   (1311, 460, '2014-10-23 00:00:00', 24),
	   (1412, 111, '2014-12-01 00:00:00', 4),
	   (1412, 210, '2014-11-15 00:00:00', 12),
	   (1412, 312, '2014-10-01 00:00:00', 10),
	   (1412, 435, '2014-10-15 00:00:00', 15),
	   (1412, 460, '2014-10-08 00:00:00', 18),
	   (1412, 515, '2014-11-05 00:00:00', 8),
	   (1520, 312, '2014-10-30 00:00:00', 17),
	   (1520, 515, '2014-10-09 00:00:00', 14),
	   (2920, 210, '2014-11-10 00:00:00', 15),
	   (2920, 460, '2014-05-20 00:00:00', 18),
	   (3001, 111, '2014-10-08 00:00:00', 14),
	   (3001, 210, '2014-10-27 00:00:00', 14),
	   (3231, 111, '2014-10-10 00:00:00', 8),
	   (3231, 312, '2014-10-24 00:00:00', 20);

-- EJERCICIOS RESUELTOS:

-- 1.A:

ALTER TABLE trabajador
ADD COLUMN edad INT;

ALTER TABLE trabajador
ADD CONSTRAINT edad_chk CHECK (edad > 0);


-- 1.B:

ALTER TABLE edificio
ADD COLUMN ciudad VARCHAR(25);


-- 1.C:

UPDATE asignacion
SET num_dias = num_dias + 4;


-- 1.D:

UPDATE edificio
SET nivel_calidad = 5
WHERE tipo = 'oficina' AND nivel_calidad = 4;

UPDATE edificio
SET categoria = 4
WHERE tipo = 'oficina' AND categoria = 1;


-- 1.E:

DELETE FROM asignacion
WHERE legajo IN (SELECT legajo
				 FROM trabajador
				 WHERE oficio = 'plomero')

DELETE FROM trabajador
WHERE oficio = 'plomero';


-- 1.F:

DELETE FROM asignacion
WHERE id_e IN (SELECT id_e
			   FROM edificio
			   WHERE tipo = 'residencia')

DELETE FROM edificio
WHERE tipo = 'residencia';


-- 2.A:

SELECT nombre
FROM trabajador
WHERE tarifa BETWEEN 10 AND 12;


-- 2.B:

SELECT oficio
FROM asignacion AS a
JOIN trabajador AS t ON t.legajo = a.legajo  
WHERE id_e = 435;


-- 2.C:

SELECT t.nombre, ts.nombre AS nombre_supervisor
FROM trabajador AS t
JOIN trabajador AS ts ON t.legajo_supv = ts.legajo


-- 2.D:

SELECT DISTINCT nombre
FROM asignacion AS a
JOIN trabajador AS t ON t.legajo = a.legajo
JOIN edificio AS e ON e.id_e = a.id_e
WHERE e.tipo = 'oficina';


-- 2.E:

SELECT DISTINCT t.nombre
FROM trabajador AS t
JOIN trabajador AS ts ON t.legajo_supv = ts.legajo
WHERE t.tarifa > ts.tarifa;


-- 2.F:







-- 2.G:






-- 2.H:






-- 2.I:




-- 2.J:




-- 2.K:







-- 2.L:






-- 2.M:






-- 2.N:





-- 2.O:




