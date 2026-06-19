-- EJERCICIO 1:

CREATE TABLE pelicula (
	id INT PRIMARY KEY,
	titulo VARCHAR(25),
	director VARCHAR(20),
	genero VARCHAR(20),
	precio_recomendado INT CHECK (precio_recomendado >= 0)
);

CREATE TABLE persona (
	id INT PRIMARY KEY,
	dni VARCHAR(10),
	tipo_documento VARCHAR(10),
	nombre VARCHAR(25),
	fecha_nacimiento DATE,
	ciudad VARCHAR(20)
);

CREATE TABLE cliente (
	id INT PRIMARY KEY,
	id_persona INT,
	codigo_socio INT CHECK (codigo_socio >= 0),
	FOREIGN KEY (id_persona) REFERENCES persona(id)
);

CREATE TABLE empleado (
	id INT PRIMARY KEY,
	id_persona INT,
	sueldo INT CHECK (sueldo >= 0),
	FOREIGN KEY (id_persona) REFERENCES persona(id)
);

CREATE TABLE alquiler (
	id_pelicula INT,
	fecha_alquiler DATE,
	id_cliente INT,
	id_empleado INT,
	fecha_devolucion DATE,
	numero_ticket VARCHAR(50),
	monto_alquiler DECIMAL(5,2) CHECK (monto_alquiler >= 0),
	PRIMARY KEY (id_pelicula, fecha_alquiler, id_cliente, id_empleado),
	FOREIGN KEY (id_pelicula) REFERENCES pelicula(id),
	FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	FOREIGN KEY (id_empleado) REFERENCES empleado(id)
);

CREATE TABLE pelicula_precio (
	id_pelicula INT,
	fecha_inicio DATE,
	fecha_fin DATE,
	precio_vigente DECIMAL(5,2),
	PRIMARY KEY (id_pelicula, fecha_inicio),
	FOREIGN KEY (id_pelicula) REFERENCES pelicula(id)
);


-- EJERCICIO 2:

ALTER TABLE pelicula
ADD CONSTRAINT nombre_director_chk UNIQUE (titulo, director, genero); 


ALTER TABLE persona
ADD CONSTRAINT persona_edad_mayor_chk CHECK (fecha_nacimiento <= '19/06/2008');


-- EJERCICIO 3:

-- 3.A:

SELECT p.*
FROM cliente AS c
JOIN persona AS p ON c.id_persona = p.id 
JOIN alquiler AS a ON a.id_cliente = c.id
JOIN pelicula AS pel ON a.id_pelicula = pel.id
WHERE AGE(p.fecha_nacimiento) > '50 years' AND pel.genero = 'Terror'

UNION

SELECT p.*
FROM cliente AS c
JOIN persona AS p ON c.id_persona = p.id 
JOIN alquiler AS a ON a.id_cliente = c.id
JOIN pelicula AS pel ON a.id_pelicula = pel.id
WHERE p.ciudad = 'Villa Fiorito' AND pel.genero = 'Comedia';


-- 3.B:

SELECT p.ciudad, SUM(a.monto_alquiler) AS monto_total_recaudado
FROM alquiler AS a
JOIN cliente AS c ON a.id_cliente = c.id
JOIN persona AS p ON c.id_persona = p.id
JOIN empleado AS e ON a.id_empleado = e.id
WHERE e.sueldo > 500000
GROUP BY p.ciudad;


-- 3.C:

SELECT p.dni, p.tipo_documento, COUNT(*) AS cantidad_alquileres, SUM(a.monto_alquiler) AS monto_total_alquilado
FROM alquiler AS a
JOIN empleado AS e ON a.id_empleado = e.id
JOIN persona AS p ON e.id_persona = p.id
GROUP BY p.dni, p.tipo_documento
HAVING COUNT(DISTINCT id_cliente) > 1000;


-- 3.D:

SELECT p.*
FROM persona AS p
JOIN cliente AS c ON p.id = c.id_persona
WHERE c.id NOT IN (
	SELECT a.id_cliente
	FROM alquiler AS a
	JOIN pelicula AS p ON a.id_pelicula = p.id
	WHERE p.director = 'Estiven Spiridina' AND p.precio_recomendado <= 15000
);


-- 3.E:

SELECT p.id, p.titulo, p.director, SUM(a.monto_alquiler) AS total_recaudado
FROM alquiler AS a
JOIN pelicula AS p ON a.id_pelicula = p.id
WHERE a.id_cliente NOT IN (
	SELECT DISTINCT a_sub.id_cliente
	FROM alquiler AS a_sub
	JOIN empleado AS e_sub ON a_sub.id_empleado = e_sub.id
	JOIN persona AS p_sub ON e_sub.id_persona = p_sub.id
	WHERE p_sub.ciudad = 'Quilmes'
) AND EXTRACT (YEAR FROM a.fecha_inicio) = 2023
GROUP BY p.id, p.titulo, p.director
ORDER BY total_recaudado DESC
LIMIT 5;
