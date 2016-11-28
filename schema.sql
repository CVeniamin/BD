SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS utilizador CASCADE;
DROP TABLE IF EXISTS fiscal CASCADE;
DROP TABLE IF EXISTS edificio CASCADE;
DROP TABLE IF EXISTS alugavel CASCADE;
DROP TABLE IF EXISTS arrenda CASCADE;
DROP TABLE IF EXISTS fiscaliza CASCADE;
DROP TABLE IF EXISTS espaco CASCADE;
DROP TABLE IF EXISTS posto CASCADE;
DROP TABLE IF EXISTS oferta CASCADE;
DROP TABLE IF EXISTS reserva CASCADE;
DROP TABLE IF EXISTS aluga CASCADE;
DROP TABLE IF EXISTS paga CASCADE;
DROP TABLE IF EXISTS estado CASCADE;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE IF NOT EXISTS utilizador
(
  nif      INT(9) UNSIGNED NOT NULL,
  nome     VARCHAR(255)    NOT NULL,
  telefone INT(9) UNSIGNED NOT NULL,
  PRIMARY KEY (nif)
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS fiscal
(
  id      INT(9) UNSIGNED NOT NULL,
  empresa VARCHAR(255)    NOT NULL,
  PRIMARY KEY (id)
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS edificio
(
  morada VARCHAR(255) NOT NULL,
  PRIMARY KEY (morada)
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS alugavel
(
  morada VARCHAR(255)     NOT NULL,
  codigo INT(11) UNSIGNED NOT NULL,
  foto   INT(10) UNSIGNED,
  PRIMARY KEY (morada, codigo),
  FOREIGN KEY (morada) REFERENCES edificio (morada)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS arrenda
(
  morada VARCHAR(255)     NOT NULL,
  codigo INT(11) UNSIGNED NOT NULL,
  nif    INT(9) UNSIGNED  NOT NULL,
  PRIMARY KEY (morada, codigo),
  FOREIGN KEY (nif) REFERENCES utilizador (nif)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (morada, codigo) REFERENCES alugavel (morada, codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS fiscaliza
(
  id     INT(9) UNSIGNED  NOT NULL,
  morada VARCHAR(255)     NOT NULL,
  codigo INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (id, morada, codigo),
  FOREIGN KEY (id) REFERENCES fiscal (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (morada, codigo) REFERENCES arrenda (morada, codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS espaco
(
  morada VARCHAR(255)     NOT NULL,
  codigo INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (morada, codigo),
  FOREIGN KEY (morada, codigo) REFERENCES alugavel (morada, codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS posto
(
  morada        VARCHAR(255)     NOT NULL,
  codigo        INT(11) UNSIGNED NOT NULL,
  codigo_espaco INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (morada, codigo),
  FOREIGN KEY (morada, codigo) REFERENCES alugavel (morada, codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (morada, codigo_espaco) REFERENCES espaco (morada, codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS oferta
(
  morada      VARCHAR(255)     NOT NULL,
  codigo      INT(11) UNSIGNED NOT NULL,
  data_inicio INT(11) UNSIGNED NOT NULL,
  data_fim    INT(11) UNSIGNED NOT NULL,
  tarifa      DECIMAL(10, 2)   NOT NULL,
  PRIMARY KEY (morada, codigo, data_inicio),
  FOREIGN KEY (morada, codigo) REFERENCES alugavel (morada, codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS reserva
(
  numero INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (numero)
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS aluga
(
  morada      VARCHAR(255)     NOT NULL,
  codigo      INT(11) UNSIGNED NOT NULL,
  data_inicio INT(11) UNSIGNED NOT NULL,
  nif         INT(9) UNSIGNED  NOT NULL,
  numero      INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (morada, codigo, data_inicio, nif, numero),
  FOREIGN KEY (numero) REFERENCES reserva (numero)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (morada, codigo, data_inicio) REFERENCES oferta (morada, codigo, data_inicio)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (nif) REFERENCES utilizador (nif)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS paga
(
  numero INT(11) UNSIGNED NOT NULL,
  data   INT(11) UNSIGNED NOT NULL,
  metodo VARCHAR(255)     NOT NULL,
  PRIMARY KEY (numero),
  FOREIGN KEY (numero) REFERENCES reserva (numero)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS estado
(
  numero      INT(11) UNSIGNED NOT NULL,
  `timestamp` INT(11) UNSIGNED NOT NULL,
  estado      VARCHAR(255)     NOT NULL,
  PRIMARY KEY (numero, `timestamp`),
  FOREIGN KEY (numero) REFERENCES reserva (numero)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = INNODB;
