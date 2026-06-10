-- SE CREAN LAS TABLAS:

CREATE TABLE libro (
	isbn SERIAL PRIMARY KEY,
	titulo VARCHAR(32)
);

CREATE TABLE ejemplar (
	cod_ejemplar SERIAL PRIMARY KEY,
	isbn_libro INT,
	edicion INT,
	CONSTRAINT fk_ejemplar FOREIGN KEY (isbn_libro)	REFERENCES libro(isbn)
);

CREATE TABLE nacionalidad (
	nombre_pais VARCHAR(9) PRIMARY KEY,
	nacionalidad VARCHAR(9)
);

CREATE TABLE socio (
	cod_socio SERIAL PRIMARY KEY,
	nombre_y_apellido VARCHAR(17),
	fecha_ingreso TIMESTAMP,
	monto_cuota INT,
	matricula INT,
	pais VARCHAR(9),
	CONSTRAINT fk_nombrepais FOREIGN KEY(pais) REFERENCES nacionalidad(nombre_pais)
);

CREATE TABLE prestamo (
	cod_ejemplar INT,
	cod_socio INT,
	fecha_prestamo TIMESTAMP,
	fecha_devolucion TIMESTAMP,
	PRIMARY KEY(cod_ejemplar, cod_socio),
	CONSTRAINT fk_cod_ejemplar FOREIGN KEY (cod_ejemplar) REFERENCES ejemplar(cod_ejemplar),
	CONSTRAINT fk_cod_socio FOREIGN KEY (cod_socio) REFERENCES socio(cod_socio)
);

-- SE INSERTAN DATOS EN LAS TABLAS CREADAS:

INSERT INTO libro (isbn, titulo)
VALUES (33058621, 'Inferno'),
	   (35494238, 'Cien Anios de Soledad'),
	   (58764384, 'Venas abiertas de America Latina'),
	   (38784929, 'Aeropuerto');

INSERT INTO ejemplar (cod_ejemplar, isbn_libro, edicion)
VALUES (503, 33058621, 2),
	   (785, 33058621, 4),
	   (065, 35494238, 1),
	   (098, 38784929, 3),
	   (223, 58764384, 3),
	   (101, 58764384, 1);

INSERT INTO nacionalidad (nombre_pais, nacionalidad)
VALUES ('Argentina', 'Argentina'),
	   ('Brasil', 'Brasilera'),
	   ('Peru', 'Peruana'),
	   ('Mexico', 'Mexicana');

INSERT INTO socio (cod_socio, nombre_y_apellido, fecha_ingreso, monto_cuota, matricula, pais)
VALUES (78, 'Sheldon Cooper', '2011-05-03 00:00:00', 12, 4, 'Brasil'),
	   (54, 'Howard Wolowitz', '2011-01-21 00:00:00', 16, 0, 'Argentina'),
	   (03, 'Amy Farrah Fowler', '2011-02-17 00:00:00', 5, 10, 'Argentina');

INSERT INTO prestamo (cod_ejemplar, cod_socio, fecha_prestamo, fecha_devolucion)
VALUES (503, 78, '2012-05-03 00:00:00', '2012/05/08'),
	   (223, 54, '2013-01-21 00:00:00', '2013/03/01'),
	   (785, 78, '2013-02-20 00:00:00', NULL),
	   (101, 03, '2013-11-17 00:00:00', '2013/11/18');

-- EJERCICIOS RESUELTOS:

-- DDL/DML-A:

	-- Hecho.


-- DDL/DML-B:

ALTER TABLE ejemplar 
ADD COLUMN año_edicion INT;


-- DDL/DML-C:

ALTER TABLE socio 
ADD COLUMN domicilio VARCHAR(150);


-- DDL/DML-D:

UPDATE socio 
SET monto_cuota = monto_cuota + 10


-- DDL/DML-E:

UPDATE socio
SET pais = 'Mexico'
WHERE nombre_y_apellido = 'Amy Farrah Fowler';

ALTER TABLE nacionalidad
ALTER COLUMN nacionalidad
TYPE VARCHAR(25);

INSERT INTO nacionalidad (nombre_pais, nacionalidad)
VALUES ('Colombia', 'Colombiana');

UPDATE socio
SET pais = 'Colombia'
WHERE nombre_y_apellido = 'Howard Wolowitz';


-- DDL/DML-F:

DELETE FROM nacionalidad
WHERE nombre_pais = 'Peru';


-- DDL/DML-G:

DELETE FROM prestamo
WHERE cod_ejemplar IN (SELECT cod_ejemplar FROM ejemplar WHERE edicion = 3);

DELETE FROM ejemplar
WHERE edicion = 3;


-- DML-A.I:

SELECT cod_socio FROM prestamo -- Representa la tabla donde únicamente está la columna cod_socio de la tabla prestamo.   

SELECT cod_ejemplar FROM prestamo -- Representa la tabla donde únicamente está la columna cod_ejemplar de la tabla prestamo.

SELECT cod_ejemplar, cod_socio FROM prestamo -- Representa la tabla donde únicamente están las coloumnas cod_ejemplar y cod_socio de la tabla prestamo.


-- DML-A.II:

	-- Sí, es el mismo porque el operador SELECT de SQL representa el operador proyección de Álgebra Relacional.


-- DML-A.III:



-- DML-A.IV:


-- DML-B.I:

-- DML-C.I:






	

	