# 1. Quais os espaços com postos que nunca foram alugados?
SELECT DISTINCT e.codigo
FROM espaco e LEFT JOIN posto p ON p.morada = e.morada AND p.codigo_espaco = e.codigo
  LEFT JOIN aluga a ON a.codigo = p.codigo
WHERE a.numero IS NULL;

# 2. Quais edifícios com um número de reservas superior à média?
CREATE TEMPORARY TABLE edificios SELECT
                                   e.morada,
                                   COUNT(*) AS cnt
                                 FROM edificio e LEFT JOIN aluga a ON a.morada = e.morada
                                 GROUP BY e.morada;
SELECT @average = AVG(cnt)
FROM edificios;
SELECT morada
FROM edificios
WHERE cnt > @average;
DROP TEMPORARY TABLE edificios;
-- OR
SELECT a.morada
FROM aluga a
GROUP BY a.morada
HAVING COUNT(*) > (SELECT AVG(t.cnt)
                   FROM (SELECT COUNT(*) AS cnt
                         FROM aluga an
                         GROUP BY an.morada) t);

# 3. Quais utilizadores cujos alugáveis foram fiscalizados sempre pelo mesmo fiscal?
SELECT a.nif
FROM arrenda a LEFT JOIN fiscaliza f ON f.codigo = a.codigo AND f.morada = a.morada
GROUP BY a.nif
HAVING COUNT(DISTINCT f.id) = 1;

# 4. Qual o montante total realizado (pago) por cada espaço durante o ano de 2016? Assuma que a tarifa indicada na oferta é diária. Deve considerar os casos em que o espaço foi alugado totalmente ou por postos.
SELECT
  a.morada,
  SUM(DATEDIFF(GREATEST(o.data_inicio, '01-01-2016'), LEAST(o.data_fim, '01-01-2017')) * o.tarifa) AS total
FROM paga p LEFT JOIN aluga a ON a.numero = p.numero
  LEFT JOIN oferta o ON o.morada = a.morada AND o.codigo = a.codigo
WHERE o.data_fim >= '01-01-2016' AND o.data_inicio < '01-01-2017'
GROUP BY o.codigo;

# 5. Quais os espaços de trabalho cujos postos nele contidos foram todos alugados? (Poralugado entende-se um posto de trabalho que tenha pelo menos uma oferta aceite,independentemente das suas datas.)
SELECT
  p.morada,
  p.codigo
FROM posto p LEFT JOIN aluga a ON a.morada = p.morada AND a.codigo = p.codigo
  LEFT JOIN estado e ON e.numero = a.numero
WHERE e.estado = 'aceite'
GROUP BY p.morada, p.codigo;




-- c)
-- gettin total reserves for each alugavel
SELECT morada, count(codigo) FROM aluga WHERE 1 GROUP BY morada;

SELECT morada, codigo FROM (SELECT morada, codigo, count(codigo) as num FROM aluga WHERE 1 GROUP BY codigo) as total_reserves WHERE num >= (select avg(num) from total_reserves);


-- b)
-- example made by le me
# select customer_name from ((select customer_name, count(account_number) as num from depositor group by customer_name) as total) natural join (select avg(num) as avg_num from (select customer_name, count(account_number) as num from depositor group by customer_name) as avg_table) as average where num > avg_num;

select morada from ((select morada, count(codigo) as num from aluga group by morada) as total) natural join (select avg(num) as avg_num from (select morada, count(codigo) as num from aluga group by morada) as avg_table) as average where num > avg_num;
