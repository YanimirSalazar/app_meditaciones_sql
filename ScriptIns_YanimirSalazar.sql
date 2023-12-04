DROP SCHEMA IF EXISTS app_meditaciones ;
CREATE SCHEMA IF NOT EXISTS app_meditaciones;
USE app_meditaciones; 

-- CONTIENE INFORMACION DE LOS USUARIOS 
CREATE TABLE IF NOT EXISTS USUARIOS (
	ID_USUARIO  INT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(50) NOT NULL,
    APELLIDO VARCHAR(50) NOT NULL,
    MAIL VARCHAR(50) NOT NULL,
    CONTRASEÑA VARCHAR(25) NOT NULL,
    ID_SUSCRIPCION INT NOT NULL,
    ID_ESTADISTICA INT,
    FECHA_NACIMIENTO DATE,
    CONSTRAINT PK_USUARIOS PRIMARY KEY (ID_USUARIO)
    ) ;
    
-- CONTIENE INFORMACION DE LAS SUSCRIPCIONES DISPONIBLES PARA REGISTRARSE EN LA APP
CREATE TABLE IF NOT EXISTS SUSCRIPCIONES (
	ID_SUSCRIPCION INT NOT NULL AUTO_INCREMENT,
	DESCRIPCION VARCHAR(150) NOT NULL,
	NOMBRE VARCHAR(50) NOT NULL,
	ID_CATEGORIA INT NOT NULL,
	CONSTRAINT PK_SUSCRIPCIONES PRIMARY KEY (ID_SUSCRIPCION)
	) ;

-- CONTIENE LA INFORMACION DE LAS CATEGORIAS DE MEDITACIONES A LAS QUE SE TIENE ACCESO CON LAS DIFERENTES SUSCRIPCIONES
CREATE TABLE IF NOT EXISTS CATEGORIAS (
	ID_CATEGORIA INT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(20) NOT NULL,
    DESCRIPCION VARCHAR(150) NOT NULL,
    ID_NIVEL INT NOT NULL,
    CONSTRAINT PK_CATEGORIAS PRIMARY KEY (ID_CATEGORIA)
    ) ;
    
-- CONTIENE INFORMACION DE LOS NIVELES QUE CONFORMAN LAS CATEGORIAS DE MEDITACIONES QUE CONFORMAN LA APP
CREATE TABLE IF NOT EXISTS NIVELES (
	ID_NIVEL INT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(20) NOT NULL,
    DESCRIPCION VARCHAR(150) NOT NULL,
    ID_MEDITACION INT NOT NULL,
    CONSTRAINT PK_NIVEL PRIMARY KEY (ID_NIVEL)
    ) ;
    
-- CONTIENE LA INFORMACION DE LAS MEDITACIONES QUE CONFORMAN LA APP
CREATE TABLE IF NOT EXISTS MEDITACIONES (
	ID_MEDITACION INT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(50) NOT NULL,
    DESCRIPCION VARCHAR(150) NOT NULL,
    AUDIO_MEDITACION BLOB,
    DURACION TIME NOT NULL,
    ID_VALORACION INT NOT NULL,
    CONSTRAINT PK_MEDITACIONES PRIMARY KEY (ID_MEDITACION)
    ) ;
    
-- CONTIENE LA INFORMACION DE LAS VALORACIONES REALIZADAS POR LOS USUARIOS A LAS MEDITACIONES DE LA APP
CREATE TABLE IF NOT EXISTS VALORACIONES (
	ID_VALORACION INT NOT NULL AUTO_INCREMENT,
    VALORACION ENUM ('DEFICIENTE', 'ACEPTABLE', 'BUENA', 'EXCELENTE') NOT NULL,
    COMENTARIO VARCHAR(150) NOT NULL,
    CONSTRAINT PK_VALORACIONES PRIMARY KEY (ID_VALORACION)
    ) ; 
    
-- CONTIENE INFORMACION REFERENTE A LAS MEDITACIONES COMPLETADAS POR LOS USUARIOS TALES COMO PROMEDIO Y TIEMPO TOTAL MEDITANDO
CREATE TABLE IF NOT EXISTS ESTADISTICAS (
	ID_ESTADISTICA INT NOT NULL AUTO_INCREMENT,
    PROMEDIO DEC(6,2),
    TOTAL TIME,
    CONSTRAINT PK_ESTADISTICAS PRIMARY KEY (ID_ESTADISTICA)
    ) ;
    
-- FOREING KEYS 

-- REFERENCE: FK_USUARIOS_SUSCRIPCIONES (table: USUARIOS)
ALTER TABLE USUARIOS ADD CONSTRAINT FK_USUARIOS_SUSCRIPCIONES FOREIGN KEY FK_USUARIOS_SUSCRIPCIONES (ID_SUSCRIPCION)
    REFERENCES SUSCRIPCIONES (ID_SUSCRIPCION);
    
-- REFERENCE: FK_SUSCRIPCIONES_CATEGORIAS (table: SUSCRIPCIONES)
ALTER TABLE SUSCRIPCIONES ADD CONSTRAINT FK_SUSCRIPCIONES_CATEGORIAS FOREIGN KEY FK_SUSCRIPCIONES_CATEGORIAS (ID_CATEGORIA)
	REFERENCES CATEGORIAS (ID_CATEGORIA);
    
-- REFERENCE: FK_CATEGORIAS_NIVELES (table: CATEGORIAS)
ALTER TABLE CATEGORIAS ADD CONSTRAINT FK_CATEGORIAS_NIVELES FOREIGN KEY FK_CATEGORIAS_NIVELES (ID_NIVEL)
	REFERENCES NIVELES (ID_NIVEL);
    
-- REFERENCE: FK_NIVELES_MEDITACIONES (table: NIVELES)
ALTER TABLE NIVELES ADD CONSTRAINT FK_NIVELES_MEDITACIONES FOREIGN KEY FK_NIVELES_MEDITACIONES (ID_MEDITACION)
	REFERENCES MEDITACIONES (ID_MEDITACION); 
    
-- REFERENCE: FK_MEDITACIONES_VALORACIONES (table: MEDITACIONES)
ALTER TABLE MEDITACIONES ADD CONSTRAINT FK_MEDITACIONES_VALORACIONES FOREIGN KEY FK_MEDITACIONES_VALORACIONES (ID_VALORACION)
	REFERENCES VALORACIONES (ID_VALORACION); 
    
-- REFERENCE: FK_USUARIOS_ESTADISTICAS (table: USUARIOS)
ALTER TABLE USUARIOS ADD CONSTRAINT FK_USUARIOS_ESTADISTICAS FOREIGN KEY FK_USUARIOS_ESTADISTICAS (ID_ESTADISTICA)
	REFERENCES ESTADISTICAS (ID_ESTADISTICA); 
    
    
-- Inserción de datos

-- Insertar registros en la tabla VALORACIONES
INSERT INTO VALORACIONES (VALORACION, COMENTARIO)
VALUES
    ('BUENA', 'Me ha ayudado a relajarme'),
    ('EXCELENTE', 'La meditación fue muy efectiva'),
    ('ACEPTABLE', 'Podría mejorar la calidad del audio'),
	('BUENA', 'Podría mejorar la calidad del audio'),
    ('BUENA', 'Me ha ayudado a relajarme y concentrarme.'),
    ('EXCELENTE', 'La meditación fue muy efectiva para reducir el estrés.'),
    ('ACEPTABLE', 'Podría mejorar la calidad del sonido.'),
    ('BUENA', 'Me gustó la meditación, me siento más tranquilo.'),
    ('EXCELENTE', 'Increíble, me ayudó a dormir mejor.'),
    ('BUENA', 'La meditación fue relajante y eficaz.'),
    ('EXCELENTE', 'La mejor meditación que he probado.'),
    ('ACEPTABLE', 'Podría ser un poco más larga.'),
    ('BUENA', 'Me ha ayudado a reducir la ansiedad.'),
    ('EXCELENTE', 'Muy profunda, la recomiendo.'),
    ('BUENA', 'Meditación agradable y calmante.');
    
-- Insertar registros en la tabla MEDITACIONES
INSERT INTO MEDITACIONES (NOMBRE, DESCRIPCION, AUDIO_MEDITACION, DURACION, ID_VALORACION)
VALUES
    ('Meditación de Respiración', 'Meditación para concentrarse en la respiración', NULL, '00:15:00', 1),
    ('Meditación para Dormir', 'Meditación para ayudar a conciliar el sueño', NULL, '00:20:00', 2),
    ('Meditación de Relajación', 'Meditación para aliviar el estrés', NULL, '00:18:00', 3),
    ('Meditación para la Salud', 'Meditación para mejorar la salud', NULL, '00:25:00', 4),
    ('Meditación Social', 'Meditación para mejorar las relaciones sociales', NULL, '00:22:00', 5),
    ('Meditación de Enfoque', 'Meditación para mejorar la concentración', NULL, '00:15:00', 6),
    ('Meditación para la Creatividad', 'Meditación para estimular la creatividad', NULL, '00:20:00', 7),
    ('Meditación de Agradecimiento', 'Meditación para practicar la gratitud', NULL, '00:18:00', 8),
    ('Meditación de Mindfulness', 'Meditación de atención plena', NULL, '00:25:00', 9),
    ('Meditación de Visualización', 'Meditación de visualización positiva', NULL, '00:22:00', 10),
    ('Meditación para la Ansiedad', 'Meditación para reducir la ansiedad', NULL, '00:15:00', 11),
    ('Meditación para el Éxito', 'Meditación para lograr el éxito', NULL, '00:20:00', 12),
    ('Meditación para la Autoestima', 'Meditación para mejorar la autoestima', NULL, '00:18:00', 13),
    ('Meditación para la Paz Interior', 'Meditación para encontrar la paz interior', NULL, '00:25:00', 14),
    ('Meditación para el Sueño Profundo', 'Meditación para un sueño reparador', NULL, '00:22:00', 15);

-- Insertar registros en la tabla NIVELES
INSERT INTO NIVELES (NOMBRE, DESCRIPCION, ID_MEDITACION)
VALUES
    ('Básico', 'Nivel básico de meditación', 1),
    ('Intermedio', 'Nivel intermedio de meditación', 2),
    ('Avanzado', 'Nivel avanzado de meditación', 3);

-- Insertar registros en la tabla CATEGORIAS
INSERT INTO CATEGORIAS (NOMBRE, DESCRIPCION, ID_NIVEL)
VALUES
    ('Fundamentos', 'Meditaciones para principiantes', 1),
    ('Sueño', 'Meditaciones para mejorar el sueño', 1),
    ('Alivio de Estrés', 'Meditaciones para reducir el estrés', 1),
    ('Salud', 'Meditaciones para la salud', 2),
    ('Social', 'Meditaciones para las relaciones sociales', 3);
    
-- Inserta registros en la tabla SUSCRIPCIONES con valores de ID_CATEGORIA definidos
INSERT INTO SUSCRIPCIONES (DESCRIPCION, NOMBRE, ID_CATEGORIA)
VALUES
    ('Suscripción Gratuita', 'Gratuita', 1),
    ('Suscripción Premium', 'Premium', 2),
    ('Suscripción con Costo', 'Costo', 3);
    
-- Insertar registros en la tabla ESTADISTICAS
INSERT INTO ESTADISTICAS (PROMEDIO, TOTAL)
VALUES
    (25.5, '10:30:00'),
    (28.0, '12:15:00'),
    (23.5, '09:45:00'),
    (30.0, '15:00:00'),
    (27.5, '11:45:00'),
    (29.5, '14:30:00'),
    (26.0, '11:00:00'),
    (24.0, '10:00:00'),
    (31.0, '16:00:00'),
    (25.0, '10:45:00'),
    (26.5, '11:15:00'),
    (29.0, '13:30:00'),
    (28.5, '12:45:00'),
    (32.0, '17:00:00'),
    (27.0, '11:30:00');

-- Insertar registros en la tabla USUARIOS
INSERT INTO USUARIOS (NOMBRE, APELLIDO, MAIL, CONTRASEÑA, ID_SUSCRIPCION, ID_ESTADISTICA, FECHA_NACIMIENTO)
VALUES
    ('Juan', 'Pérez', 'juan@gmail.com', 'Segura123!', 1, 1, '1990-05-15'),
    ('María', 'López', 'maria@hotmail.com', 'Contraseña#2', 2, 2, '1985-08-22'),
    ('Pedro', 'Gómez', 'pedro@gmail.com', 'M1Clav3r', 1, 3, '1992-03-10'),
    ('Luis', 'Rodríguez', 'luis@gmail.com', 'P@ssw0rd', 3, 4, '1988-11-30'),
    ('Ana', 'Fernández', 'ana@hotmail.com', 'S3gur@456', 2, 5, '1995-04-18'),
    ('Marta', 'Martínez', 'marta@gmail.com', 'Marta#2022', 1, 6, '1987-09-25'),
    ('Carlos', 'Sánchez', 'carlos@hotmail.com', 'C@rl0sPwd', 3, 7, '1991-07-12'),
    ('Sofía', 'Torres', 'sofia@gmail.com', 'S0f1@1234', 2, 8, '1986-02-08'),
    ('Diego', 'García', 'diego@gmail.com', 'D!3g0Pass', 1, 9, '1993-06-04'),
    ('Laura', 'Ramírez', 'laura@hotmail.com', 'Ram1rezPwd', 2, 10, '1990-01-19'),
    ('Roberto', 'Hernández', 'roberto@gmail.com', 'R0bert0#Pwd', 3, 11, '1989-10-28'),
    ('Elena', 'Díaz', 'elena@hotmail.com', '3l3n@Pwd', 1, 12, '1984-12-15'),
    ('Javier', 'Molina', 'javier@hotmail.com', 'J@v1er123', 2, 13, '1983-03-21'),
    ('Silvia', 'Ortega', 'silvia@hotmail.com', 'Silvia!Pwd', 1, 14, '1981-07-07'),
    ('Hugo', 'Navarro', 'hugo@hotmail.com', 'Hug0P@ss', 3, 15, '1982-09-10');


