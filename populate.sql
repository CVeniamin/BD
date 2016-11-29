insert into utilizador values (950245011,'Chaim Tobias', 969885689);
insert into utilizador values (354396861,'Iser Rapp',918876950);
insert into utilizador values (366165710,'Agam Kauffmann',929848162);
insert into utilizador values (808866092,'Yussel Schenck', 930678582);
insert into utilizador values (822402323,'Ber Landau',935019501);
insert into utilizador values (822402583,'Yachin Morgenstern', 967092724);
insert into utilizador values (362985512,'Udi Lehrer',927785432);
insert into utilizador values (842505457,'Ziv Harel',934937561);
insert into utilizador values (902250809,'Mor Rothenberg', 918071174);

insert into fiscal values (258777899,'Jodoc Lda');
insert into fiscal values (628921909,'Columba Lda');
insert into fiscal values (537663041,'Glaucia Lda');
insert into fiscal values (406492394,'Aquila Inc');
insert into fiscal values (926716989,'Oluwakanyinsola Inc');
insert into fiscal values (242778839,'Shahnaz Ltd');
insert into fiscal values (760988375,'Opeyemi Inc');
insert into fiscal values (774608544,'Omobolanle Ltd');
insert into fiscal values (444756563,'Nur Inc');

# espaco 1
SET @morada = 'Dusty Rabbit Knoll';
insert into edificio VALUES (@morada);
CALL INSERT_ESPACO(@morada, NULL);
SET @espaco_id = LAST_INSERT_ID();
CALL INSERT_POSTO(@morada, @espaco_id, NULL);
CALL INSERT_POSTO(@morada, @espaco_id, NULL);
CALL INSERT_POSTO(@morada, @espaco_id, NULL);

#edificio 2
SET @morada = 'Noble Path';
insert into edificio VALUES (@morada);
CALL INSERT_ESPACO(@morada, NULL);
SET @espaco_id = LAST_INSERT_ID();
CALL INSERT_POSTO(@morada, @espaco_id, NULL);
CALL INSERT_POSTO(@morada, @espaco_id, NULL);
CALL INSERT_POSTO(@morada, @espaco_id, NULL);


#edificio 3
SET @morada = 'Silent Barn Promenade';
insert into edificio VALUES (@morada);
CALL INSERT_ESPACO(@morada, NULL);
SET @espaco_id = LAST_INSERT_ID();
CALL INSERT_POSTO(@morada, @espaco_id, NULL);
CALL INSERT_POSTO(@morada, @espaco_id, NULL);
CALL INSERT_POSTO(@morada, @espaco_id, NULL);


#edificio 4
SET @morada = 'Middle Pond Landing';
insert into edificio VALUES (@morada);
CALL INSERT_ESPACO(@morada, NULL);
SET @espaco_id = LAST_INSERT_ID();
CALL INSERT_POSTO(@morada, @espaco_id, NULL);
CALL INSERT_POSTO(@morada, @espaco_id, NULL);
CALL INSERT_POSTO(@morada, @espaco_id, NULL);

insert into reserva values ();

insert into arrenda values ('Dusty Rabbit Knoll',1,950245011);
insert into arrenda values('Noble Path',2,366165710);
insert into arrenda values('Silent Barn Promenade',3,808866092);
insert into arrenda values('Middle Pond Landing',4,950245011);
# insert into arrenda values('Foggy Island Terrace',5,362985512);
# insert into arrenda values('Harvest Willow Passage',6,842505457);

insert into fiscaliza values (258777899,'Dusty Rabbit Knoll',1);
insert into fiscaliza values(774608544,'Noble Path',2);
insert into fiscaliza values(774608544,'Silent Barn Promenade',3);
insert into fiscaliza values(444756563,'Middle Pond Landing',4);


insert into oferta values ('Dusty Rabbit Knoll',1,'2016-01-02 16:00:00','2016-01-04 16:00:00',20);
insert into oferta values ('Noble Path',1,'2016-01-02 16:00:00','2016-01-06 16:00:00',25);
insert into oferta values ('Silent Barn Promenade',1,'2016-01-02 16:00:00','2016-01-06 16:00:00',27);


CALL INSERT_ALUGA('Dusty Rabbit Knoll',1,'2016-01-02 16:00:00',950245011);
CALL INSERT_ALUGA('Silent Barn Promenade',1,'2016-01-02 16:00:00',950245011);
CALL INSERT_ALUGA('Noble Path',1,'2016-01-03 16:00:00',950245011);
