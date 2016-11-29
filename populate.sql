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
insert into fiscal values (062892193,'Columba Lda');
insert into fiscal values (537663041,'Glaucia Lda');
insert into fiscal values (406492394,'Aquila Inc');
insert into fiscal values (926716989,'Oluwakanyinsola Inc');
insert into fiscal values (242778839,'Shahnaz Ltd');
insert into fiscal values (760988375,'Opeyemi Inc');
insert into fiscal values (774608544,'Omobolanle Ltd');
insert into fiscal values (444756563,'Nur Inc');

insert into edificio VALUES ('Dusty Rabbit Knoll'), ('Noble Path'), ('Silent Barn Promenade'), ('Middle Pond Landing'), ('Foggy Island Terrace'), ('Harvest Willow Passage');

insert into alugavel values ('Dusty Rabbit Knoll',1,1),('Noble Path',2,2),('Silent Barn Promenade',3,3),('Middle Pond Landing',4,4),('Foggy Island Terrace',5,5),('Harvest Willow Passage',6,6);

insert into arrenda values ('Dusty Rabbit Knoll',1,950245011),('Noble Path',2,366165710),('Silent Barn Promenade',3,808866092),('Middle Pond Landing',4,950245011),('Foggy Island Terrace',5,362985512),('Harvest Willow Passage',6,842505457);


insert into fiscaliza values (123,'Dusty Rabbit Knoll',1),(345,'Noble Path',2),(567,'Silent Barn Promenade',3),(789,'Middle Pond Landing',4),(910,'Foggy Island Terrace',5);

# espaco 1
INSERT INTO alugavel VALUES ('Dusty Rabbit Knoll', NULL, NULL); # alugavel espaco 1
INSERT INTO espaco VALUES ('Dusty Rabbit Knoll', LAST_INSERT_ID()); # espaco 1
SELECT @espaco_last_id = LAST_INSERT_ID();
INSERT INTO alugavel VALUES ('Dusty Rabbit Knoll', NULL, NULL); # alugavel espaco 1, posto 1
INSERT INTO posto VALUES ('Dusty Rabbit Knoll', LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 1
INSERT INTO alugavel VALUES ('Dusty Rabbit Knoll', NULL, NULL); # alugavel espaco 1, posto 2
INSERT INTO posto VALUES ('Dusty Rabbit Knoll', LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 2
INSERT INTO alugavel VALUES ('Dusty Rabbit Knoll', NULL, NULL); # alugavel espaco 1, posto 3
INSERT INTO posto VALUES ('Dusty Rabbit Knoll', LAST_INSERT_ID(), @espaco_last_id); # espaco 1, posto 3


insert into espaco values('Noble Path',2);
insert into espaco values('Silent Barn Promenade',3);
insert into espaco values('Middle PondLanding',4);
insert into espaco values('Foggy Island Terrace',5);
insert into espaco values('Harvest Willow Passage',6);

insert into posto values('Noble Path',2,2);
insert into posto values('Silent Barn Promenade',3,3);
insert into posto values('Middle Pond Landing',2,4);

insert into reserva values (1);
