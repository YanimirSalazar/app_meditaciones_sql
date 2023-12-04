-- DESAFIO COMPLEMENTARIO: CREACIÓN DE USUARIOS Y ASIGNACIÓN DE PERMISOS

-- CREA EL PRIMER USUARIO
CREATE USER IF NOT EXISTS 'user_1'@'localhost' IDENTIFIED BY 'abc123';

-- ASIGNAR PERMISOS PRIMER USUARIO: Tiene permisos de solo lectura en todas las tablas del esquema app_meditaciones
GRANT SELECT ON app_meditaciones.* TO 'user_1'@'localhost'; 


-- CREA EL SEGUNDO USUARIO
CREATE USER IF NOT EXISTS 'user_2'@'localhost' IDENTIFIED BY 'ABC123';

-- ASIGNAR PERMISOS SEGUNDO USUARIO: Tiene permisos de lectura, inserción, modificación de datos en todas las tablas del esquema app_meditaciones
GRANT SELECT, INSERT ,UPDATE ON app_meditaciones.* TO 'user_2'@'localhost';

