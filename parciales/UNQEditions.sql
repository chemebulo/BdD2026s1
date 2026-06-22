-- EJERCICIO 1:

-- 1.1: Opción B.


-- 1.2: Opcion B.


-- 1.3: Opcion C.


-- 1.4: Opcion C.


-- 1.5: Opcion D.


-- EJERCICIO 2:

-- 2.1:

-- Para la tabla PUBLICACION es necesario que antes exista la tabla EDITORIAL y GENERO.

CREATE TABLE publicacion (
	id_publicacion INT PRIMARY KEY,
	titulo VARCHAR(150),
	descripcion VARCHAR(255),
	id_genero INT,
	tipo VARCHAR(50),
	id_editorial INT,
	FOREIGN KEY (id_genero) REFERENCES genero(id_genero),
	FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial)
);

-- Para la tabla GENERO no existen dependencias.

CREATE TABLE genero (
	id_genero INT PRIMARY KEY,
	nombre VARCHAR(75)
);

-- Para la tabla PUBLICACION_AUTOR es necesario que antes exista la tabla AUTOR y PUBLICACION.

CREATE TABLE publicacion_autor (
	id_publicacion INT,
	id_autor INT,
	rol VARCHAR(25),
	PRIMARY KEY (id_publicacion, id_autor),
	FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion),
	FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);


-- 2.2.A:

ALTER TABLE publicacion
ADD CONSTRAINT titulo_genero_editorial UNIQUE (id_editorial, titulo, id_genero);


-- 2.2.B:

ALTER TABLE edicion
ADD CONSTRAINT estado_edicion_chk CHECK (estado IN ('borrador', 'en revisión', 'publicada'));


-- 2.3:

SELECT p.id_publicacion, p.titulo
FROM publicacion AS p
JOIN genero AS g
	ON p.id_genero = g.id_genero
JOIN publicacion_autor AS pa
	ON p.id_publicacion = pa.id_publicacion
JOIN autor AS a
	ON pa.id_autor = a.id_autor
JOIN edicion AS e 
	ON p.id_publicacion = e.id_publicacion 
JOIN revision AS r
	ON e.id_edicion = r.id_edicion
JOIN revisor AS rev
	ON r.id_revisor = rev.id_revisor
WHERE g.nombre = 'Ficción' AND r.estado AND rev.especialidad = 'Literatura' AND a.nacionalidad = 'Argentina';


-- 2.4:

SELECT g.nombre AS nombre_genero, COUNT(DISTINCT pa.id_autor) AS cantidad_total_autores
FROM genero AS g
JOIN publicacion AS p
	ON g.id_genero = p.id_genero
JOIN publicacion_autor AS pa
	ON p.id_publicacion = pa.id_publicacion
JOIN edicion AS e
	ON p.id_publicacion = e.id_publicacion
WHERE pa.id_genero IN (
	SELECT p.id_genero
	FROM publicacion AS p
	JOIN edicion AS e
		ON p.id_publicacion = e.id_publicacion
	WHERE e.estado = 'publicada'
)
GROUP BY g.nombre
HAVING COUNT(DISTINCT pa.id_autor) > 3)


-- 2.5:

SELECT a.id_autor, per.nombre, per.apellido
FROM persona AS per
JOIN autor AS a ON per.id_persona = a.id_persona
JOIN publicacion_autor AS pa ON 
LEFT JOIN (
	SELECT DISTINCT id_publicacion
	FROM edicion
	WHERE estado = 'en revision'
) AS er ON pa.id_publcacion ON er.id_publicacion
GROUP BY a.id_autor, per.nombre, per.apellido
HAVING COUNT(DISTINCT pa.id_publicacion) > 3 AND COUNT(er.id_publicacion) >= 1;


-- 2.6:

SELECT DISTINCT ed.id_editorial AS editorial
FROM editorial AS ed
JOIN publicacion AS p ON ed.id_editorial = p.id_editorial
JOIN publicacion_autor AS pa ON p.id_publicacion = pa.id_publicacion
JOIN edicion AS e ON p.id_publicacion = e.id_publicacion
WHERE e.estado = 'en revision' AND ed.id_editorial NOT IN (
	SELECT p.id_editorial
	FROM publicacion AS p
	JOIN edicion AS e ON p.id_publicacion ON e.id_publicacion
	WHERE estado = 'publicada'
)








