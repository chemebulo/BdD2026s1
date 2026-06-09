-- SE CREAN LAS TABLAS:

CREATE TABLE manada (
	region VARCHAR(75),
	origen VARCHAR(75),
	temperatura DECIMAL(4, 2),
	poblacion INT CHECK (poblacion >= 0),
	PRIMARY KEY (region, origen)
);

CREATE TABLE lobo (
	nombre VARCHAR(25),
	peso INT CHECK (peso >= 0),
	edad INT CHECK (edad >= 0),
	region VARCHAR(75),
	origen VARCHAR(75),
	PRIMARY KEY (nombre, region, origen),
	FOREIGN KEY (region, origen) REFERENCES manada(region, origen)
);

CREATE TABLE rastreador (
	id INT PRIMARY KEY,
	porcentaje_bateria DECIMAL(4, 2)
);

CREATE TABLE encuentra (
	nombre VARCHAR(25),
	region VARCHAR(75),
	origen VARCHAR(75),
	id INT,
	fecha DATE,
	PRIMARY KEY (nombre, region, origen, id, fecha),
	FOREIGN KEY (nombre, region, origen) REFERENCES lobo(nombre, region, origen),
	FOREIGN KEY (id) REFERENCES rastreador(id)
);

-- SE INSERTAN DATOS A LAS TABLAS CREADAS:

INSERT INTO manada (region, origen, temperatura, poblacion) 
VALUES ('Patagonia', 'Sur', -3.20, 15),
	   ('Cuyo', 'Norte', 17.50, 10);

INSERT INTO lobo (nombre, peso, edad, region, origen)
VALUES ('Kimi', 45, 7, 'Patagonia', 'Sur'), 
	   ('Balta', 39, 5, 'Cuyo', 'Norte');

INSERT INTO rastreador (id, porcentaje_bateria)
VALUES (101, 87.20), 
 	   (102, 56.70);

INSERT INTO encuentra (nombre, region, origen, id, fecha)
VALUES ('Kimi', 'Patagonia', 'Sur', 101, '2025-10-20'), 
	   ('Balta', 'Cuyo', 'Norte', 102, '2025-10-19');
