-- SE CREAN LAS TABLAS:

CREATE TABLE local (
	ciudad VARCHAR(15),
	legajo_gerente INT CHECK (legajo_gerente >= 0),
	cant_pisos INT,
	horario_cierre TIME,
	PRIMARY KEY (ciudad, legajo_gerente)
);

CREATE TABLE factura (
	nombre VARCHAR(15),
	gusto VARCHAR(20),
	peso DECIMAL(3,1) CHECK (peso >= 0),
	ancho DECIMAL(3,1) CHECK (ancho > 0),
	alto DECIMAL(3,1) CHECK (alto > 0),
	tiene_crema BOOLEAN,
	tiene_ddl BOOLEAN,
	PRIMARY KEY (nombre, gusto)
);

CREATE TABLE pedido (
	cliente VARCHAR(15),
	nro_pedido INT CHECK (nro_pedido >= 0),
	total_final DECIMAL(10, 2),
	total_iva DECIMAL(10, 2),
	fecha_entrega_estimada TIMESTAMP,
	seña DECIMAL(10, 2) CHECK (seña >= 0),
	PRIMARY KEY (cliente, nro_pedido)
);

CREATE TABLE incluye (
	nombre VARCHAR(15),
	gusto VARCHAR(20),
	cliente VARCHAR(15),
	nro_pedido INT,
	PRIMARY KEY (nombre, gusto, cliente, nro_pedido),
	FOREIGN KEY (nombre, gusto) REFERENCES factura(nombre, gusto),
	FOREIGN KEY (cliente, nro_pedido) REFERENCES pedido(cliente, nro_pedido)
);

CREATE TABLE entrega (
	cliente VARCHAR(15),
	nro_pedido INT,
	ciudad VARCHAR(15),
	gerente INT,
	fecha_entrega_pedido TIMESTAMP,
	PRIMARY KEY (cliente, nro_pedido, ciudad, gerente),
	FOREIGN KEY (cliente, nro_pedido) REFERENCES pedido(cliente, nro_pedido),
	FOREIGN KEY (ciudad, gerente) REFERENCES local(ciudad, legajo_gerente)
);

-- SE INSERTAN DATOS EN LAS TABLAS CREADAS:

INSERT INTO local (ciudad, legajo_gerente, cant_pisos, horario_cierre)
VALUES ('Quilmes', 304, 25, '20:30:00'),
	   ('Avellaneda', 55, 3, '19:00:00');

INSERT INTO factura (nombre, gusto, peso, ancho, alto, tiene_crema, tiene_ddl)
VALUES ('Torta de Marroc', 'Dulce', 0.50, 0.30, 0.15, TRUE, TRUE),
	   ('Tiramisu', 'Dulce', 0.45, 0.40, 0.20, FALSE, FALSE);

INSERT INTO pedido (cliente, nro_pedido, total_final, total_iva, fecha_entrega_estimada, seña)
VALUES ('Ricardo Fort', 9480, 15300.20, 3100.02, '2026-06-25 19:30:00', 10000.00),
   	   ('Lionel Messi', 2944, 20150.50, 4030.05, '2026-06-09 10:45:00', 8000.00);

INSERT INTO incluye (nombre, gusto, cliente, nro_pedido)
VALUES ('Torta de Marroc', 'Dulce', 'Ricardo Fort', 9480),
	   ('Tiramisu', 'Dulce', 'Lionel Messi', 2944);

INSERT INTO entrega (cliente, nro_pedido, ciudad, gerente, fecha_entrega_pedido)
VALUES ('Ricardo Fort', 9480, 'Quilmes', 304, '2026-06-25 19:18:53'),
	   ('Lionel Messi', 2944, 'Avellaneda', 55, '2026-06-09 10:42:35');