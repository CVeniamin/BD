DELIMITER $$

DROP PROCEDURE IF EXISTS `INSERT_ALUGAVEL`$$
CREATE PROCEDURE `INSERT_ALUGAVEL`(IN morada VARCHAR(255), IN codigo VARCHAR(255),IN foto VARCHAR(255))
  BEGIN
    INSERT INTO alugavel VALUES (morada, codigo, foto);
  END$$

DROP PROCEDURE IF EXISTS `INSERT_ESPACO`$$
CREATE PROCEDURE `INSERT_ESPACO`(IN morada VARCHAR(255), IN codigo VARCHAR(255),IN foto VARCHAR(255))
  BEGIN
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


DROP PROCEDURE IF EXISTS `INSERT_ALUGA`$$
CREATE PROCEDURE `INSERT_ALUGA`(IN morada VARCHAR(255),IN codigo VARCHAR(255), IN data_inicio DATE,IN nif VARCHAR(9),
  IN numero VARCHAR(255))
  BEGIN
    INSERT INTO reserva VALUES (numero);
    INSERT INTO aluga VALUES (morada,codigo,data_inicio,nif,numero);
  END$$

#RI-1:Não podem existir ofertas com datas sobrepostas
DROP TRIGGER IF EXISTS `check_date`$$
CREATE TRIGGER `check_date`
BEFORE INSERT ON oferta
FOR EACH ROW
  BEGIN
    IF EXISTS(SELECT *
              FROM oferta
              WHERE (morada = new.morada AND codigo = new.codigo)
                    AND ((new.data_inicio <= data_fim AND new.data_fim >= data_inicio )
                         OR (new.data_inicio > new.data_fim))) THEN
      CALL data_oferta_sobrepostas();
    END IF;
  END; $$

DROP TRIGGER IF EXISTS `check_date_pagamento`$$
CREATE TRIGGER `check_date_pagamento`
BEFORE INSERT ON paga
FOR EACH ROW
  BEGIN
    IF EXISTS(SELECT *
              FROM paga p, estado e
              WHERE (p.numero = e.numero) AND ((new.data < e.time_stamp ))) THEN
      CALL timestamp_sobreposto();
    END IF;
  END $$

DELIMITER ;
