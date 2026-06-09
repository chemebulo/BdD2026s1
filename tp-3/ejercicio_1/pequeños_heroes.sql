-- SE CREAN LAS TABLAS:

CREATE TABLE protector (
	pasaporte VARCHAR(9) PRIMARY KEY,
	altura INT CHECK (altura BETWEEN 0 AND 220),
	peso INT CHECK (peso BETWEEN 0 AND 300)
);

CREATE TABLE herramienta (
	nombre VARCHAR(15) PRIMARY KEY,
	poder INT,
	origen VARCHAR(15),
	pasaporte VARCHAR(9),
	FOREIGN KEY (pasaporte) REFERENCES protector(pasaporte)
);

CREATE TABLE ciudad (
	nombre VARCHAR(15) PRIMARY KEY,
	ubicacion VARCHAR(15),
	poblacion INT
);

CREATE TABLE protege (
	nombre VARCHAR(15),
	pasaporte VARCHAR(9),
	fecha DATE,
	fue_exitoso BOOLEAN,
	PRIMARY KEY (nombre, pasaporte, fecha),
	FOREIGN KEY (nombre) REFERENCES ciudad(nombre),
	FOREIGN KEY (pasaporte) REFERENCES protector(pasaporte)
);

-- SE INSERTAN DATOS EN LAS TABLAS CREADAS:

INSERT INTO protector (pasaporte, altura, peso)
VALUES ('KFJ355791', 175, 78),
	   ('MNO981444', 190, 95);

INSERT INTO herramienta (nombre, poder, origen, pasaporte)
VALUES ('Eco de Luden', 105, 'Demacia', 'KFJ355791'),
	   ('Filo Infinito', 57, 'Abismo Oscuro', 'MNO981444');

INSERT INTO ciudad (nombre, ubicacion, poblacion)
VALUES ('Quilmes', 'Buenos Aires', 595000),
	   ('Azul', 'Buenos Aires', 120000);

INSERT INTO protege (nombre, pasaporte, fecha, fue_exitoso)
VALUES ('Quilmes', 'KFJ355791', '2023-10-22', TRUE),
	   ('Azul', 'MNO981444', '2025-01-01', FALSE);