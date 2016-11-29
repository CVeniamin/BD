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
SELECT @morada = 'Dusty Rabbit Knoll';
insert into edificio VALUES (@morada);
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1
INSERT INTO espaco VALUES (@morada, LAST_INSERT_ID()); # espaco 1
SELECT @espaco_last_id = LAST_INSERT_ID();
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 1
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 1
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 2
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 2
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 3
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 3

#edificio 2
SELECT @morada = 'Noble Path';
insert into edificio VALUES (@morada);
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1
INSERT INTO espaco VALUES (@morada, LAST_INSERT_ID()); # espaco 1
SELECT @espaco_last_id = LAST_INSERT_ID();
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 1
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 1
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 2
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 2
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 3
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 3


#edificio 3
SELECT @morada = 'Silent Barn Promenade';
insert into edificio VALUES (@morada);
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1
INSERT INTO espaco VALUES (@morada, LAST_INSERT_ID()); # espaco 1
SELECT @espaco_last_id = LAST_INSERT_ID();
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 1
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 1
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 2
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 2
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 3
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 3


#edificio 4
SELECT @morada = 'Middle Pond Landing';
insert into edificio VALUES (@morada);
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1
INSERT INTO espaco VALUES (@morada, LAST_INSERT_ID()); # espaco 1
SELECT @espaco_last_id = LAST_INSERT_ID();
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 1
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 1
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 2
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 2
INSERT INTO alugavel VALUES (@morada, NULL, NULL); # alugavel espaco 1, posto 3
INSERT INTO posto VALUES (@morada, LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 3

#
# insert into espaco values('Foggy Island Terrace',5);
# insert into espaco values('Harvest Willow Passage',6);
#
# insert into posto values('Noble Path',2,2);
# insert into posto values('Silent Barn Promenade',3,3);
# insert into posto values('Middle Pond Landing',2,4);

insert into reserva values (1);

insert into arrenda values ('Dusty Rabbit Knoll',1,950245011);
insert into arrenda values('Noble Path',2,366165710);
insert into arrenda values('Silent Barn Promenade',3,808866092);
insert into arrenda values('Middle Pond Landing',4,950245011);
# insert into arrenda values('Foggy Island Terrace',5,362985512);
# insert into arrenda values('Harvest Willow Passage',6,842505457);

insert into aluga values ('Dusty Rabbit Knoll',1,'02-01-2016',950245011,1);

insert into fiscaliza values (258777899,'Dusty Rabbit Knoll',1),(774608544,'Noble Path',2),(774608544,'Silent
Barn Promenade',NULL ),(444756563,'Middle Pond Landing',4),(926716989,'Foggy Island Terrace',5);