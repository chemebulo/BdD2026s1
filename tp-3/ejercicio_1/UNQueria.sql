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
	FOREIGN KEY (nombre_comiqueria) REFERENCES comiqueria(nombre_comiqueria)
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