/*
 drop table bank_news cascade;
 drop table borrower cascade;
 drop table loan cascade;
 drop table depositor cascade;
 drop table account cascade;
 drop table customer cascade;
 drop table branch cascade;
*/


drop table if exists utilizador cascade;
drop table if exists fiscal cascade;
drop table if exists edificio cascade;
drop table if exists alugavel cascade;
drop table if exists arrenda cascade;
drop table if exists fiscaliza cascade;
drop table if exists espaco cascade;
drop table if exists posto cascade;
drop table if exists oferta cascade;
drop table if exists reserva cascade;
drop table if exists aluga cascade;
drop table if exists paga cascade;
drop table if exists estado cascade;
drop table if exists utilizador cascade;
drop table if exists fiscal cascade;
drop table if exists edificio cascade;
drop table if exists alugavel cascade;
drop table if exists arrenda cascade;
drop table if exists fiscaliza cascade;
drop table if exists espaco cascade;
drop table if exists posto cascade;
drop table if exists oferta cascade;
drop table if exists reserva cascade;
drop table if exists aluga cascade;
drop table if exists paga cascade;
drop table if exists estado cascade;
drop table if exists utilizador cascade;
drop table if exists fiscal cascade;
drop table if exists edificio cascade;
drop table if exists alugavel cascade;
drop table if exists arrenda cascade;
drop table if exists fiscaliza cascade;
drop table if exists espaco cascade;
drop table if exists posto cascade;
drop table if exists oferta cascade;
drop table if exists reserva cascade;
drop table if exists aluga cascade;
drop table if exists paga cascade;
drop table if exists estado cascade;
drop table if exists edificio cascade;

create table if not exists utilizador
   (nif     int(9) unsigned not null,
    nome  varchar(255)  not null,
    telefone int(9) unsigned not null,
    primary key(nif));

create table if not exists fiscal
   (id      int(9) unsigned not null,
    empresa varchar(255)  not null,
    primary key(id));

create table if not exists edificio
   (morada  varchar(255)  not null,
    primary key(morada));

create table if not exists alugavel
   (morada  varchar(255)  not null,
    codigo  int(11) not null,
    foto    int(10) unsigned,
    primary key(morada,codigo),
    foreign key(morada) references edificio(morada) on delete cascade);

create table if not exists arrenda
   (morada 	varchar(255)	not null,
    codigo 	int(11)	not null,
    nif 	int(9) unsigned not null ,
    primary key(morada,codigo),
    foreign key(nif) references utilizador(nif),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade);

create table if not exists fiscaliza
   (id      int(9) unsigned not null,
    morada  varchar(255)    not null,
    codigo  int(11) not null,
    primary key(id,morada,codigo),
    foreign key(morada,codigo) references arrenda(morada,codigo) on delete cascade);

create table if not exists espaco
   (morada  varchar(255)    not null,
    codigo  int(11) not null,
    primary key(morada,codigo),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade);

create table if not exists posto
   (morada  varchar(255)    not null,
    codigo  int(11) not null,
    codigo_espaco int(11) not null,
    primary key(morada,codigo),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade,
    foreign key(morada,codigo_espaco) references espaco(morada,codigo) on delete cascade);

create table if not exists oferta
   (morada  varchar(255) not null,
    codigo  int(11) unsigned not null,
    data_inicio int(11) unsigned  not null,
    data_fim int(11) unsigned  not null,
    tarifa decimal(10,2)  not null,
    primary key(morada,codigo,data_inicio),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade);

create table if not exists reserva
   (numero int unsigned not null,
    primary key(numero));

create table if not exists aluga
   (morada  varchar(255) not null,
    codigo  int(11) unsigned not null,
    data_inicio int(11) unsigned not null,
    nif int(9) unsigned not null,
    numero int unsigned not null,
    primary key(morada,codigo,data_inicio,nif,numero),
    foreign key(numero) references reserva(numero) on delete cascade,
    foreign key(morada,codigo,data_inicio) references oferta(morada,codigo,data_inicio) on delete cascade,
    foreign key(nif) references utilizador(nif) on delete cascade);

create table if not exists paga
   (numero int unsigned not null,
    data  int(11) unsigned not null,
    metodo varchar(255) not null,
    primary key(numero),
    foreign key(numero) references reserva(numero) on delete cascade);

create table if not exists estado
   (numero int unsigned not null,
    `timestamp`  int(11) unsigned not null,
    estado varchar(255) not null,
    primary key(numero,`timestamp`),
    foreign key(numero) references reserva(numero) on delete cascade);
