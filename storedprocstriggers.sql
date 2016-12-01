
DELIMITER $$
DROP TRIGGER IF EXISTS `alugavel_codigo`$$
CREATE TRIGGER `alugavel_codigo`
BEFORE INSERT ON `alugavel`
FOR EACH ROW
  BEGIN
    /*    SET NEW.codigo = (SELECT IFNULL(MAX(codigo), 0) + 1
                                         FROM alugavel
                                         WHERE morada = NEW.morada);*/
    SET @new_codigo = (SELECT ifnull(max(codigo), 0) + 1
                       FROM alugavel
                       WHERE morada = new.morada);
    SET new.codigo = @new_codigo;
  END$$

DROP PROCEDURE IF EXISTS `INSERT_ALUGAVEL`$$
CREATE PROCEDURE `INSERT_ALUGAVEL`(IN morada VARCHAR(255), IN codigo VARCHAR(255),IN foto VARCHAR(255))
  BEGIN
    INSERT INTO alugavel VALUES (morada, codigo, foto);
#     SELECT LAST_INSERT_ID(@new_codigo);
  END$$

DROP PROCEDURE IF EXISTS `INSERT_ESPACO`$$
CREATE PROCEDURE `INSERT_ESPACO`(IN morada VARCHAR(255), IN codigo VARCHAR(255),IN foto VARCHAR(255))
  BEGIN
#     SELECT foto INTO @foto FROM  alugavel WHERE morada= @morada;
    CALL INSERT_ALUGAVEL(morada,codigo,foto);
    INSERT INTO espaco VALUES (morada,codigo);
  END$$

DROP PROCEDURE IF EXISTS `INSERT_POSTO`$$
CREATE PROCEDURE `INSERT_POSTO`(IN morada VARCHAR(255), IN codigo_posto VARCHAR(255),IN codigo_espaco VARCHAR(255),
  IN foto VARCHAR(255))
  BEGIN
    CALL INSERT_ALUGAVEL(morada,codigo_posto, foto);
    INSERT INTO posto VALUES (morada,codigo_posto,codigo_espaco);
  END$$


DROP PROCEDURE IF EXISTS `INSERT_OFERTA`$$
CREATE PROCEDURE `INSERT_OFERTA`(IN morada VARCHAR(255), IN codigo INT(11), IN foto MEDIUMBLOB)
  BEGIN
    CALL INSERT_ALUGAVEL(morada, foto);
    INSERT INTO posto VALUES (morada, LAST_INSERT_ID(), espaco_id);
  END$$

CREATE TRIGGER `aluga_numero`
BEFORE INSERT ON `aluga`
FOR EACH ROW
  BEGIN
    /*    SET NEW.codigo = (SELECT IFNULL(MAX(codigo), 0) + 1
                                         FROM alugavel
                                         WHERE morada = NEW.morada);*/
    SET @new_numero = (SELECT ifnull(max(numero), 0) + 1
                       FROM aluga
                       WHERE morada = new.morada);
    SET new.numero = @new_numero;
  END$$

DROP PROCEDURE IF EXISTS `INSERT_ALUGA`$$
CREATE PROCEDURE `INSERT_ALUGA`(IN morada VARCHAR(255),IN codigo VARCHAR(255), IN data_inicio DATE,IN nif VARCHAR(9),
  IN numero VARCHAR(255))
  BEGIN
    INSERT INTO reserva VALUES (numero);
    INSERT INTO aluga VALUES (morada,codigo,data_inicio,nif,numero);
  END$$

#
# DROP FUNCTION IF EXISTS `GET_RESERVA`$$
# CREATE FUNCTION `GET_RESERVA`() RETURNS VARCHAR(255)
#   BEGIN
#     SET @last_id= (SELECT numero FROM reserva
#                   ORDER BY numero DESC
#                   LIMIT 1);
#     RETURN @last_id;
#   END$$



#NEED's fixing
DROP TRIGGER IF EXISTS `check_date`$$
CREATE TRIGGER `check_date`
BEFORE INSERT ON oferta
FOR EACH ROW
  BEGIN
    IF (new. > data_inicio AND new.data_inicio > new.data_fim AND new.data_fim <= data_fim)
    THEN
      CALL data_oferta_indisponivel();
    END IF;
  END; $$

DELIMITER ;
