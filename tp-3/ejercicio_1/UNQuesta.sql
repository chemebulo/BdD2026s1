-- SE CREAN LAS TABLAS:

CREATE TABLE alumno (
	legajo INT PRIMARY KEY,
	nombre VARCHAR(25),
	dni VARCHAR(12),
	telefono VARCHAR(10),
	fecha_nacimiento DATE
);

CREATE TABLE comision (
	numero INT CHECK (numero >= 0),
	materia VARCHAR(25),
	nombre_profesor VARCHAR(25) UNIQUE,
	PRIMARY KEY (numero, materia)
);

CREATE TABLE pregunta (
	consigna VARCHAR(255),
	numero INT,
	materia VARCHAR(25),
	tema VARCHAR(15) CHECK (tema IN ('Matemática', 'Lengua', 'Geografía', 'Historia')),
	dificultad VARCHAR(10) CHECK (dificultad IN ('Difícil', 'Media', 'Fácil')),
	PRIMARY KEY (consigna, numero, materia),
	FOREIGN KEY (numero, materia) REFERENCES comision(numero, materia)
);

CREATE TABLE respuesta (
	legajo INT,
	consigna VARCHAR(255),
	numero INT,
	materia VARCHAR(25),
	opcion VARCHAR(1) CHECK (opcion IN ('A', 'B', 'C', 'D', 'E')),
	puntaje DECIMAL(5,2) CHECK (puntaje BETWEEN 0 AND 100),
	legajo_docente INT,
	PRIMARY KEY (legajo, consigna, numero, materia, legajo_docente),
	FOREIGN KEY (legajo) REFERENCES alumno(legajo),
	FOREIGN KEY (consigna, numero, materia) REFERENCES pregunta(consigna, numero, materia)
);

-- SE INSERTAN DATOS EN LAS TABLAS CREADAS:

INSERT INTO alumno (legajo, nombre, dni, telefono, fecha_nacimiento)
VALUES (4981, 'Benjamín Maldonado', '53.381.227', '1193327564', '2004-06-10'),
	   (7762, 'Marcos Gimenez', '30.912.991', '1183756193', '2001-03-31');

INSERT INTO comision (numero, materia, nombre_profesor)
VALUES (5, 'Programación Funcional', 'Fidel'),
	   (3, 'Bases de Datos', 'Jorge Gomez');

INSERT INTO pregunta (consigna, numero, materia, tema, dificultad)
VALUES ('¿Cómo se define el principio por inducción estructural?', 5, 'Programación Funcional', 'Matemática', 'Difícil'),
	   ('¿Cuál es el resultado de AxB?', 3, 'Bases de Datos', 'Matemática', 'Media');

INSERT INTO respuesta (legajo, consigna, numero, materia, opcion, puntaje, legajo_docente)
VALUES (4981, '¿Cómo se define el principio por inducción estructural?', 5, 'Programación Funcional', 'C', 75.00, 5979),
	   (7762, '¿Cuál es el resultado de AxB?', 3, 'Bases de Datos', 'A', 100.00, 9133);