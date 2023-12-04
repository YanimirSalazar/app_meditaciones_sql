USE app_meditaciones; 

-- SELECT @@autocommit;
SET @@autocommit = 0;

-- TABLA 1: VALORACIONES: ELIMINACIÓN DE REGISTROS
-- SELECT * FROM VALORACIONES; 
START TRANSACTION ;
DELETE  FROM VALORACIONES WHERE ID_VALORACIONES = 33 ;
DELETE  FROM VALORACIONES WHERE ID_VALORACIONES = 32 ;
DELETE  FROM VALORACIONES WHERE ID_VALORACIONES = 31 ;
DELETE  FROM VALORACIONES WHERE ID_VALORACIONES = 30 ;
-- ROLLBACK;
-- COMMIT;

-- TABLA 2: MEDITACIONES
-- SELECT * FROM MEDITACIONES;
START TRANSACTION ;
INSERT INTO MEDITACIONES (NOMBRE, DESCRIPCION, AUDIO_MEDITACION, DURACION, ID_VALORACION)
VALUES
    ('Meditación de la Mañana', 'Una meditación para comenzar el día con energía positiva', NULL, '00:10:00', 4),
    ('Meditación para la Calma', 'Un ejercicio para encontrar la paz interior', NULL, '00:15:00', 5),
    ('Meditación Guiada para el Estrés', 'Una guía para aliviar el estrés diario', NULL, '00:12:30', 4),
    ('Meditación de Gratitud', 'Práctica enfocada en cultivar la gratitud', NULL, '00:18:00', 5);
SAVEPOINT sp1;

INSERT INTO MEDITACIONES (NOMBRE, DESCRIPCION, AUDIO_MEDITACION, DURACION, ID_VALORACION)
VALUES
    ('Meditación para el Sueño Profundo', 'Ayuda a conciliar el sueño y tener un descanso reparador', NULL, '00:20:00', 3),
    ('Meditación de Atención Plena', 'Desarrolla la conciencia plena en el momento presente', NULL, '00:22:30', 4),
    ('Meditación para la Concentración', 'Mejora la concentración y el enfoque mental', NULL, '00:25:00', 5),
    ('Meditación de Relajación Profunda', 'Sumérgete en una relajación total para liberar tensiones', NULL, '00:30:00', 3);
SAVEPOINT sp2;
-- RELEASE SAVEPOINT sp1;








