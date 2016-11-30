
DELIMITER $$
DROP TRIGGER IF EXISTS `alugavel_codigo`$$
#USE `ist182058`
$$
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
CREATE PROCEDURE `INSERT_ALUGAVEL`(IN morada VARCHAR(255), IN foto MEDIUMBLOB)
  BEGIN
    INSERT INTO alugavel VALUES (morada, 0, foto);
    SELECT LAST_INSERT_ID(@new_codigo);
  END$$

DROP PROCEDURE IF EXISTS `INSERT_ESPACO`$$
CREATE PROCEDURE `INSERT_ESPACO`(IN morada VARCHAR(255), IN foto MEDIUMBLOB)
  BEGIN
    CALL INSERT_ALUGAVEL(morada, foto);
    INSERT INTO espaco VALUES (morada, LAST_INSERT_ID());
  END$$

DROP PROCEDURE IF EXISTS `INSERT_POSTO`$$
CREATE PROCEDURE `INSERT_POSTO`(IN morada VARCHAR(255), IN espaco_id INT(11), IN foto MEDIUMBLOB)
  BEGIN
    CALL INSERT_ALUGAVEL(morada, foto);
    INSERT INTO posto VALUES (morada, LAST_INSERT_ID(), espaco_id);
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
CREATE PROCEDURE `INSERT_ALUGA`(IN morada VARCHAR(255),IN codigo INT(11), IN data_inicio DATETIME,IN nif INT(9))
  BEGIN
    INSERT INTO reserva VALUE ();
    INSERT INTO aluga VALUES (morada,codigo,data_inicio,nif,0);
#     SELECT LAST_INSERT_ID(@new_numero);
  END$$


DROP TRIGGER IF EXISTS `check_date`$$
CREATE TRIGGER check_date 
BEFORE INSERT ON oferta 
FOR EACH ROW
  BEGIN
    IF  (new.morada = morada AND new.codigo = codigo AND new.data_inicio >= data_inicio AND  new.data_fim <= data_fim)  THEN
      CALL data_oferta_indisponivel();
    END IF;
  END $$

DELIMITER ;
