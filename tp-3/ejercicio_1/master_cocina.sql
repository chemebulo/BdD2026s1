-- SE CREAN LAS TABLAS:

CREATE TABLE restaurante (
	razon_social VARCHAR(25) PRIMARY KEY,
	fundacion TIMESTAMP,
	cant_estrellas INT CHECK (cant_estrellas BETWEEN 0 AND 5)
);

CREATE TABLE maestro (
	nombre VARCHAR(20),
	restaurante VARCHAR(25),
	fecha_nac TIMESTAMP,
	tiempo_profesional INT,
	PRIMARY KEY (nombre, restaurante),
	FOREIGN KEY (restaurante) REFERENCES restaurante(razon_social)
);

CREATE TABLE participante (
	apodo VARCHAR(20),
	edad INT CHECK (edad >= 0),
	ciudad VARCHAR(25),
	maestro VARCHAR(20),
	restaurante VARCHAR(25),
	PRIMARY KEY (apodo, maestro, restaurante),
	FOREIGN KEY (maestro, restaurante) REFERENCES maestro(nombre, restaurante)
);

CREATE TABLE programa (
	numero INT PRIMARY KEY,
	fecha DATE,
	hora_inicio TIME,
	grabacion INT
);

CREATE TABLE plato (
	plato VARCHAR(15),
	apodo VARCHAR(20),
	nombre VARCHAR(20),
	razon_social VARCHAR(25),
	tipo VARCHAR(10),
	es_vegano BOOLEAN,
	numero INT,
	PRIMARY KEY (plato, apodo, nombre, razon_social, numero),
	FOREIGN KEY (apodo, nombre, razon_social) REFERENCES participante(apodo, maestro, restaurante),
	FOREIGN KEY (numero) REFERENCES programa(numero)
);

-- SE INSERTAN DATOS A LAS TABLAS CREADAS:

INSERT INTO restaurante (razon_social, fundacion, cant_estrellas) 
VALUES ('Parrilla Don Julio', '2004-01-22 08:30:00', 4),
	   ('Fogon Asado', '1993-04-18 11:00:00', 5);

INSERT INTO maestro (nombre, restaurante, fecha_nac, tiempo_profesional)
VALUES ('Carlos Sainz', 'Parrilla Don Julio', '1983-04-15 11:35:00', 13),
	   ('Alfredo Linguini', 'Fogon Asado', '1994-09-27 22:22:22', 9);

INSERT INTO participante (apodo, edad, ciudad, maestro, restaurante)
VALUES ('Kurt Cobain', 27, 'Seattle', 'Carlos Sainz', 'Parrilla Don Julio'),
	   ('Mirtha Legrand',98, 'Buenos Aires','Alfredo Linguini', 'Fogon Asado');

INSERT INTO programa (numero, fecha, hora_inicio, grabacion)
VALUES (1, '2026-06-02', '20:00:00', 4),
	   (2, '2026-06-09', '20:00:00', 10);

INSERT INTO plato (plato, apodo, nombre, razon_social, tipo, es_vegano, numero)
VALUES ('Asado con papas', 'Kurt Cobain', 'Carlos Sainz', 'Parrilla Don Julio', 'Entrada', FALSE, 1),
	   ('Sorrentinos', 'Mirtha Legrand', 'Alfredo Linguini', 'Fogon Asado', 'Principal', FALSE, 2);