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
    codigo  integer	not null,
    foto    integer(10) unsigned,
    primary key(morada,codigo),
    foreign key(morada) references edificio(morada) on delete cascade);


create table arrenda
   (morada 	varchar(255)	not null,
    codigo 	integer	not null,
    nif 	int(9) not null unsigned,
    primary key(morada,codigo),
    foreign key(nif) references user(nif),
    foreign key(morada,codigo) references alugavel(morada,codigo));


create table fiscaliza
   (id 	    int(9) not null unsigned,
    morada 	varchar(255)    not null,
    codigo 	integer	not null,
    primary key(id,morada,codigo),
    foreign key(morada,codigo) references arrenda(morada,codigo));

create table espaco
   (morada 	varchar(255)    not null,
    codigo 	integer	not null,
    primary key(morada,codigo),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade);

create table posto
   (morada 	varchar(255)    not null,
    codigo 	integer	not null,
    codigo_espaco integer	not null,
    primary key(morada,codigo),
    foreign key(morada,codigo) references alugavel(morada,codigo) on delete cascade,
    foreign key(morada,codigo_espaco) references espaco(morada,codigo) on delete cascade);

create table oferta
   (morada 	varchar(255)    not null,
    codigo 	integer	not null,
    codigo_espaco integer	not null,
    codigo_espaco integer	not null,
    primary key(morada,codigo),
    foreign key(morada,codigo) references espaco(morada,codigo) on delete cascade);


create table reserva
   (id 	    integer(9) not null unsigned,
    primary key(id));
