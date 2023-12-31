USE app_meditaciones; 

-- CREACIÓN DE FUNCIONES

-- FUNCIÓN 1: función que calcula la edad del usuario, el id del usuario es ingresado por parámetro, 
-- se utiliza la fecha de nacimiento de la tabla usuarios para realizar el cálculo.
DROP FUNCTION IF EXISTS FN_CALCULAR_EDAD_USUARIOS;
DELIMITER //
CREATE FUNCTION FN_CALCULAR_EDAD_USUARIOS(P_ID_USUARIO INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE V_FECHA_NACIMIENTO DATE;
  DECLARE V_EDAD INT;
  
  SELECT FECHA_NACIMIENTO INTO V_FECHA_NACIMIENTO
  FROM USUARIOS
  WHERE ID_USUARIO = P_ID_USUARIO;
  
  SET V_EDAD = TIMESTAMPDIFF(YEAR, V_FECHA_NACIMIENTO, CURDATE());
  
  RETURN V_EDAD;
END;
//


DELIMITER ;

SELECT FN_CALCULAR_EDAD_USUARIOS(1) AS EDAD;


-- FUNCIÓN 2: función que calcula la cantidad de usuarios por suscripción de la tabla usuarios, 
-- se ingresa por parámetro el id de la suscripción. 
DROP FUNCTION IF EXISTS FN_CALCULAR_USUARIOS_SUSCRIPCION;
DELIMITER //
CREATE FUNCTION FN_CALCULAR_USUARIOS_SUSCRIPCION(P_ID_SUSCRIPCION INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE V_CANTIDAD INT;
  
  SELECT COUNT(*) INTO V_CANTIDAD
  FROM USUARIOS
  WHERE ID_SUSCRIPCION = P_ID_SUSCRIPCION;
  
  RETURN V_CANTIDAD;
END;
//
DELIMITER ;

SELECT FN_CALCULAR_USUARIOS_SUSCRIPCION(2) AS CANT_SUSCRIPCIONES;

-- FUNCIÓN 3: función que retorna el tipo de suscripción según el id_usuario en la tabla,
-- suscripciones, el id del usuario se ingresa por parámetro.
DROP FUNCTION IF EXISTS FN_OBTENER_SUSCRIPCION_USUARIO;
DELIMITER //
CREATE FUNCTION FN_OBTENER_SUSCRIPCION_USUARIO(P_ID_USUARIO INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  DECLARE V_DESC_SUSCRIPCION VARCHAR(20);
  
  SELECT NOMBRE INTO V_DESC_SUSCRIPCION
  FROM SUSCRIPCIONES
  WHERE ID_SUSCRIPCION = (SELECT ID_SUSCRIPCION FROM USUARIOS WHERE ID_USUARIO = P_ID_USUARIO);
  RETURN V_DESC_SUSCRIPCION;
END;
//
DELIMITER ;

SELECT FN_OBTENER_SUSCRIPCION_USUARIO(3) AS SUSCRIPCION_ACTUAL;
