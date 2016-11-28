#queries


-- a)
SELECT * FROM espacos e LEFT JOIN postos p USING(morada,codigo) WHERE p.morada IS NULL AND codigo IS NULL;

-- b)
SELECT * FROM espacos e LEFT JOIN postos p USING(morada,codigo) WHERE p.morada IS NULL AND codigo IS NULL;

-- c)
-- gettin total reserves for each alugavel
SELECT morada, count(codigo) FROM aluga WHERE 1 GROUP BY morada;

SELECT morada, codigo FROM (SELECT morada, codigo, count(codigo) as num FROM aluga WHERE 1 GROUP BY codigo) as total_reserves WHERE num >= (select avg(num) from total_reserves);


-- b)
-- example made by le me
select customer_name from ((select customer_name, count(account_number) as num from depositor group by customer_name) as total) natural join (select avg(num) as avg_num from (select customer_name, count(account_number) as num from depositor group by customer_name) as avg_table) as average where num > avg_num;

select morada from ((select morada, count(codigo) as num from aluga group by morada) as total) natural join (select avg(num) as avg_num from (select morada, count(codigo) as num from aluga group by morada) as avg_table) as average where num > avg_num;
