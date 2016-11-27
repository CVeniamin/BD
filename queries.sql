
#queries

select balance from account natural join depositor where account.account_number = depositor.account_number and depositor.customer_name="Smith";


SELECT * FROM espacos e LEFT JOIN postos p USING(morada,codigo) WHERE p.morada IS NULL AND codigo IS NULL;