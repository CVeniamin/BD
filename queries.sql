# 1. Quais os espaços com postos que nunca foram alugados?
SELECT DISTINCT e.morada,e.codigo,p.codigo
FROM espaco e LEFT JOIN posto p ON p.morada = e.morada AND p.codigo_espaco = e.codigo
  LEFT JOIN aluga a ON a.codigo = p.codigo
WHERE a.numero IS NULL AND p.codigo IS NOT NULL;

# 2. Quais edifícios com um número de reservas superior à média?
SELECT a.morada
FROM aluga a
GROUP BY a.morada
HAVING COUNT(*) > (SELECT AVG(t.cnt)
                   FROM (SELECT COUNT(*) AS cnt
                         FROM aluga an
                         GROUP BY an.morada) t);

# 3. Quais utilizadores cujos alugáveis foram fiscalizados sempre pelo mesmo fiscal?
SELECT u.nome, u.nif
FROM  user u NATURAL JOIN (SELECT a.nif as nif
                           FROM arrenda a LEFT JOIN fiscaliza f ON f.codigo = a.codigo AND f.morada = a.morada
                           GROUP BY a.nif
                           HAVING COUNT(DISTINCT f.id) = 1) as utilizador
WHERE u.nif = utilizador.nif;


# 4. Qual o montante total realizado (pago) por cada espaço durante o ano de 2016? Assuma que a tarifa indicada na oferta é diária.
# Deve considerar os casos em que o espaço foi alugado totalmente ou por postos.
SELECT
  a.morada,
  a.codigo,
  SUM(DATEDIFF(LEAST(o.data_fim, '2017-01-01'),GREATEST(o.data_inicio, '2016-01-01')) * o.tarifa) AS total
FROM paga p LEFT JOIN aluga a ON a.numero = p.numero
  LEFT JOIN oferta o ON o.morada = a.morada AND o.codigo = a.codigo
WHERE o.data_fim >= '2016-01-01' AND o.data_inicio < '2017-01-01'
GROUP BY a.morada,a.codigo;

# 5. Quais os espaços de trabalho cujos postos nele contidos foram todos alugados? (Poralugado entende-se um posto de trabalho que tenha pelo menos uma oferta aceite,independentemente das suas datas.)
SELECT
  p.morada,
  p.codigo_espaco
FROM posto p LEFT JOIN aluga a ON a.morada = p.morada AND a.codigo = p.codigo
  LEFT JOIN estado e ON e.numero = a.numero AND e.estado = 'aceite'
WHERE 1
GROUP BY p.codigo_espaco
HAVING SUM(IF(ISNULL(e.estado), 1, 0)) = 0;
