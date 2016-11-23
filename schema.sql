/*
 drop table bank_news cascade;
 drop table borrower cascade;
 drop table loan cascade;
 drop table depositor cascade;
 drop table account cascade;
 drop table customer cascade;
 drop table branch cascade;
*/


create table user
   (nif     int(9) not null unsigned,
    nome 	varchar(255)	not null,
    telefone int(9) not null unsigned,
    primary key(nif));

create table fiscal
   (id 	    int(9) not null unsigned,
    empresa varchar(255)	not null,
    primary key(nif));

create table edificio
   (morada 	varchar(255)	not null,
    primary key(morada));

create table alugavel
   (morada 	varchar(255)	not null,
    codigo  int	not null,
    foto    int(10) unsigned,
    primary key(morada,codigo),
    foreign key(morada) references edificio(morada) on delete cascade);
create table arrenda
   (morada 	varchar(255)	not null,
    codigo 	int	not null,
    nif 	int(9) not null unsigned,
    primary key(morada,codigo),
    foreign key(nif) references user(nif),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade);

create table fiscaliza
   (id 	    int(9) not null unsigned,
    morada 	varchar(255)    not null,
    codigo 	int	not null,
    primary key(id,morada,codigo),
    foreign key(morada,codigo) references arrenda(morada,codigo));
    foreign key(morada,codigo) references arrenda(morada,codigo) /* on delete cascade */);
create table espaco
   (morada 	varchar(255)    not null,
    codigo 	int	not null,
    primary key(morada,codigo),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade);

create table posto
   (morada 	varchar(255)    not null,
    codigo 	int	not null,
    codigo_espaco int	not null,
    primary key(morada,codigo),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade,
    foreign key(morada,codigo_espaco) references espaco(morada,codigo) on delete cascade);
    foreign key(morada,codigo) references espaco(morada,codigo) on delete cascade);

create table oferta
   (morada 	varchar(255)    not null,
    codigo 	int	not null,
    codigo_espaco int	not null,
    codigo_espaco int not null,
    data_inicio timestamp  not null,
    data_fim timestamp  not null,
    tarifa decimal(10,2)	not null,
    primary key(morada,codigo),
    foreign key(morada,codigo) references espaco(morada,codigo) on delete cascade);

create table aluga
   (morada  varchar(255)    not null,
    codigo  int not null,
    data_inicio timestamp not null,
    nif int(9) not null,
    numero int not null,
    primary key(morada,codigo,data_inicio,nif,numero),
    foreign key(numero) references reserva(numero) /* on delete cascade */),
    foreign key(morada,codigo,data_inicio) references oferta(morada,codigo,data_inicio) /* on delete cascade */),
    foreign key(nif) references user(nif) on delete cascade);

create table paga
   (numero int not null,
    data  timestamp not null,
    metodo varchar(255) not null,
    primary key(numero),
    foreign key(numero) references reserva(numero) on delete cascade);

create table estado
   (numero int not null,
    `timestamp`  timestamp not null,
    estado varchar(255) not null,
    primary key(numero,`timestamp`),
    foreign key(numero) references reserva(numero) on delete cascade);

create table reserva
   (numero int not null,
    primary key(numero);
