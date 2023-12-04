USE app_meditaciones; 

-- CREACIÓN DE STORED PROCEDURE

/* Stored precedure 1: permite ordenar una tabla solicitando el nombre de la tabla, el campo de ordenamiento 
y si se ordena de forma ascendente o descendente.*/ 
DROP PROCEDURE IF EXISTS  SP_ORDENAR_TABLA;

DELIMITER //
CREATE PROCEDURE SP_ORDENAR_TABLA( IN P_NOMBRE_TABLA VARCHAR(50),
                                   IN P_CAMPO_ORDENAR VARCHAR(50),
                                   IN P_ORDEN VARCHAR(50) )
BEGIN
    SET @query = CONCAT('SELECT * FROM ', P_NOMBRE_TABLA, ' ORDER BY ', P_CAMPO_ORDENAR, ' ', P_ORDEN);
    PREPARE param_stmt FROM @query;
    EXECUTE param_stmt;
    DEALLOCATE PREPARE param_stmt;
END//

DELIMITER ;

CALL SP_ORDENAR_TABLA('usuarios', 'id_usuario', 'ASC');


/* Stored Procedure 2: Permite insertar una nueva valoración, eliminar la última valoración y dar un mensaje 
cuando la opción elegida es diferente a Insertar o eliminar*/ 
DROP PROCEDURE IF EXISTS SP_INSERTAR_ELIMINAR_VALORACIONES;

DELIMITER //
CREATE PROCEDURE SP_INSERTAR_ELIMINAR_VALORACIONES(
    IN P_OPERACION VARCHAR(10),
    IN P_VALORACION ENUM('DEFICIENTE', 'ACEPTABLE', 'BUENA', 'EXCELENTE'),
    IN P_COMENTARIO VARCHAR(150)
)
BEGIN
    IF P_OPERACION = 'INSERT' THEN
        INSERT INTO VALORACIONES (VALORACION, COMENTARIO)
        VALUES (P_VALORACION, P_COMENTARIO);
        SELECT 'La Valoración fue insertada exitosamente.' AS RESULTADO;
    ELSEIF P_OPERACION = 'DELETE' THEN
        SET @max_id = (SELECT MAX(ID_VALORACION) FROM VALORACIONES); -- selecciona la ultima valoración
        DELETE FROM VALORACIONES WHERE ID_VALORACION = @max_id;
        SELECT 'La Última valoración fue eliminada exitosamente.' AS RESULTADO;
    ELSE
        SELECT 'Operación no válida. Use "INSERT" o "DELETE" como operación.' AS RESULTADO;
    END IF;
END //

DELIMITER ;


CALL SP_INSERTAR_ELIMINAR_VALORACIONES('INSERT', 'BUENA', 'Buena meditación.');
-- CALL SP_INSERTAR_ELIMINAR_VALORACIONES('NULO', NULL, NULL);
-- CALL SP_INSERTAR_ELIMINAR_VALORACIONES('DELETE', NULL, NULL);
SELECT * FROM VALORACIONES; 

