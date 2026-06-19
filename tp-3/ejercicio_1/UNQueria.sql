-- SE CREAN LAS TABLAS:

CREATE TABLE comiqueria (
	nombre_comiqueria VARCHAR(25) PRIMARY KEY, 
	forma_contributiva VARCHAR(20) CHECK (forma_contributiva IN ('Esquema Piramidal', 'Monotributo', 'Cooperativa', 'Empresa')), 
	ciudad VARCHAR(25) UNIQUE, 
	direccion VARCHAR(25) UNIQUE, 
	piso INT UNIQUE, 
	local INT UNIQUE
);

CREATE TABLE editorial (
	nombre_editorial VARCHAR(25) PRIMARY KEY, 
	jefe VARCHAR(25), 
	nro_empleados INT CHECK (nro_empleados >= 0), 
	al_dia_con_afip BOOLEAN
);

CREATE TABLE comic (
	nombre VARCHAR(25), 
	tomo INT CHECK (tomo >= 0), 
	demografia VARCHAR(10) CHECK (demografia IN ('Shonen', 'Seinen', 'Shoujo', 'Josei')), 
	origen VARCHAR(15), 
	edicion VARCHAR(25),
	PRIMARY KEY (nombre, tomo),
	FOREIGN KEY (edicion) REFERENCES editorial(nombre_editorial)
);

CREATE TABLE venta (
	nombre VARCHAR(25), 
	tomo INT, 
	nombre_comiqueria VARCHAR(25), 
	fecha DATE,
	cantidad_comprada INT CHECK (cantidad_comprada >= 0),
	forma_pago VARCHAR(20),
	PRIMARY KEY (nombre, tomo, nombre_comiqueria, fecha),
	FOREIGN KEY (nombre, tomo) REFERENCES comic(nombre, tomo),
	FORCREATE TABLE libro (
	isbn SERIAL PRIMARY KEY,
	titulo VARCHAR(32)
);

INSERT INTO libro (isbn, titulo)
VALUES (33058621, 'Inferno'),
			 (35494238, 'Cien Anios de Soledad'),
			 (58764384, 'Venas abiertas de America Latina'),
			 (38784929, 'Aeropuerto');

CREATE TABLE ejemplar (
	cod_ejemplar SERIAL PRIMARY KEY,
	isbn_libro INT,
	edicion INT,
	CONSTRAINT fk_ejemplar FOREIGN KEY (isbn_libro)
	REFERENCES libro(isbn)
);

INSERT INTO ejemplar (cod_ejemplar, isbn_libro, edicion)
VALUES (503, 33058621, 2),
			 (785, 33058621, 4),
			 (065, 35494238, 1),
			 (098, 38784929, 3),
			 (223, 58764384, 3),
			 (101, 58764384, 1);

CREATE TABLE nacionalidad (
	nombre_pais VARCHAR(9) PRIMARY KEY,
	nacionalidad VARCHAR(9)
);

INSERT INTO nacionalidad (nombre_pais, nacionalidad)
VALUES ('Argentina', 'Argentina'),
			 ('Brasil', 'Brasilera'),
			 ('Peru', 'Peruana'),
			 ('Mexico', 'Mexicana');

CREATE TABLE socio (
	cod_socio SERIAL PRIMARY KEY,
	nombre_y_apellido VARCHAR(17),
	fecha_ingreso timestamp,
	monto_cuota INT,
	matricula INT,
	pais VARCHAR(9),
	CONSTRAINT fk_nombrepais FOREIGN KEY(pais) REFERENCES nacionalidad(nombre_pais)
);

INSERT INTO socio (cod_socio, nombre_y_apellido, fecha_ingreso, monto_cuota, matricula, pais)
VALUES (78, 'Sheldon Cooper', '2011-05-03 00:00:00', 12, 4, 'Brasil'),
			 (54, 'Howard Wolowitz', '2011-01-21 00:00:00', 16, 0, 'Argentina'),
			 (03, 'Amy Farrah Fowler', '2011-02-17 00:00:00', 5, 10, 'Argentina');

CREATE TABLE prestamo (
	cod_ejemplar INT,
	cod_socio INT,
	fecha_prestamo TIMESTAMP,
	fecha_devolucion TIMESTAMP,
	PRIMARY KEY(cod_ejemplar,cod_socio),
	CONSTRAINT fk_cod_ejemplar FOREIGN KEY (cod_ejemplar)
	REFERENCES ejemplar(cod_ejemplar),
	CONSTRAINT fk_cod_socio FOREIGN KEY (cod_socio)
	REFERENCES socio(cod_socio)
);

INSERT INTO prestamo (cod_ejemplar, cod_socio, fecha_prestamo, fecha_devolucion)
VALUES (503, 78, '2012-05-03 00:00:00', '2012/05/08'),
			 (223, 54, '2013-01-21 00:00:00', '2013/03/01'),
			 (785, 78, '2013-02-20 00:00:00', NULL),
			 (101, 03, '2013-11-17 00:00:00', '2013/11/18');
EIGN KEY (nombre_comiqueria) REFERENCES comiqueria(nombre_comiqueria)
);

-- SE INSERTAN DATOS EN LAS TABLAS CREADAS:

INSERT INTO comiqueria (nombre_comiqueria, forma_contributiva, ciudad, direccion, piso, local) 
VALUES ('OtakuWorld', 'Monotributo', 'Buenos Aires', 'Corrientes 4805', 1, 12),
	   ('MegaComics', 'Empresa', 'Cordoba', 'San Martin 2980', 0, 1);

INSERT INTO editorial (nombre_editorial, jefe, nro_empleados, al_dia_con_afip) 
VALUES ('Shueisha', 'Tanaka', 2500, TRUE),
	   ('Kodansha', 'Hayashi', 1800, TRUE);

INSERT INTO comic (nombre, tomo, demografia, origen, edicion)
VALUES ('Naruto', 1, 'Shonen', 'Japon', 'Shueisha'),
	   ('Naruto', 2, 'Shonen', 'Japon', 'Kodansha');

INSERT INTO venta (nombre, tomo, nombre_comiqueria, fecha, cantidad_comprada, forma_pago) 
VALUES ('Naruto', 1, 'OtakuWorld', '2026-04-10', 5, 'Tarjeta'),
	   ('Naruto', 2, 'MegaComics', '2026-05-05', 2, 'Efectivo');