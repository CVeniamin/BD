/*
 drop table bank_news cascade;
 drop table borrower cascade;
 drop table loan cascade;
 drop table depositor cascade;
 drop table account cascade;
 drop table customer cascade;
 drop table branch cascade;
*/
create table customer
   (customer_name varchar(255)not null unique,
    customer_street varchar(255)not null,
    customer_city varchar(255)not null,
    primary key(customer_name));

create table branch
   (branch_name varchar(255)not null unique,
    branch_city varchar(255)not null,
    assets numeric(20,2)not null,
    primary key(branch_name));

create table account
   (account_number varchar(255)not null unique,
    branch_namevarchar(255)not null,
    balance numeric(20,2)not null,
    primary key(account_number),
    foreign key(branch_name) references branch(branch_name));

create table depositor
   (customer_name varchar(255)not null,
    account_number varchar(255)not null,
    primary key(customer_name, account_number),
    foreign key(customer_name) references customer(customer_name),
    foreign key(account_number) references account(account_number));

create table loan
   (loan_number varchar(255)not null unique,
    branch_namevarchar(255)not null,
    amount numeric(20,2)not null,
    primary key(loan_number),
    foreign key(branch_name) references branch(branch_name));

create table borrower
   (customer_name varchar(255)not null,
    loan_number varchar(255)not null,
    primary key(customer_name, loan_number),
    foreign key(customer_name) references customer(customer_name),
    foreign key(loan_number) references loan(loan_number));

create table bank_news
    (id int primary key,
    title varchar(250),
    body text,
    fulltext ( title , body )
    ) engine=MyISAM;

/* populate relations */

insert into customervalues ('Jones','Main','Harrison');
insert into customervalues ('Smith','Main','Rye');
insert into customervalues ('Hayes','Main','Harrison');
insert into customervalues ('Curry','North','Rye');
insert into customervalues ('Lindsay','Park','Pittsfield');
insert into customervalues ('Turner','Putnam','Stamford');
insert into customervalues ('Williams','Nassau','Princeton');
insert into customervalues ('Adams','Spring','Pittsfield');
insert into customervalues ('Johnson','Alma','Palo Alto');
insert into customervalues ('Glenn','Sand Hill','Woodside');
insert into customervalues ('Brooks','Senator','Brooklyn');
insert into customervalues ('Green','Walnut','Stamford');
insert into customervalues ('Jackson','University','Salt Lake');
insert into customervalues ('Majeris','First','Rye');
insert into customervalues ('McBride','Safety','Rye');

insert into branchvalues ('Downtown','Brooklyn', 900000);
insert into branchvalues ('Redwood','Palo Alto',2100000);
insert into branchvalues ('Perryridge','Horseneck',1700000);
insert into branchvalues ('Mianus','Horseneck', 400200);
insert into branchvalues ('Round Hill','Horseneck',8000000);
insert into branchvalues ('Pownal','Bennington', 400000);
insert into branchvalues ('North Town','Rye',3700000);
insert into branchvalues ('Brighton','Brooklyn',7000000);
insert into branchvalues ('Central','Rye', 400280);

insert into accountvalues ('A-101','Downtown',500);
insert into accountvalues ('A-215','Mianus',700);
insert into accountvalues ('A-102','Perryridge',400);
insert into accountvalues ('A-305','Round Hill',350);
insert into accountvalues ('A-201','Perryridge',900);
insert into accountvalues ('A-222','Redwood',700);
insert into accountvalues ('A-217','Brighton',750);
insert into accountvalues ('A-333','Central',850);
insert into accountvalues ('A-444','North Town',625);

insert into depositor values ('Johnson','A-101');
insert into depositor values ('Smith','A-215');
insert into depositor values ('Hayes','A-102');
insert into depositor values ('Hayes','A-101');
insert into depositor values ('Turner','A-305');
insert into depositor values ('Johnson','A-201');
insert into depositor values ('Jones','A-217');
insert into depositor values ('Lindsay','A-222');
insert into depositor values ('Majeris','A-333');
insert into depositor values ('Smith','A-444');

insert into loanvalues ('L-17','Downtown',1000);
insert into loanvalues ('L-23','Redwood',2000);
insert into loanvalues ('L-15','Perryridge',1500);
insert into loanvalues ('L-14','Downtown',1500);
insert into loanvalues ('L-93','Mianus',500);
insert into loanvalues ('L-11','Round Hill',900);
insert into loanvalues ('L-16','Perryridge',1300);
insert into loanvalues ('L-20','North Town',7500);
insert into loanvalues ('L-21','Central',570);

insert into borrower values ('Jones','L-17');
insert into borrower values ('Smith','L-23');
insert into borrower values ('Hayes','L-15');
insert into borrower values ('Jackson','L-14');
insert into borrower values ('Curry','L-93');
insert into borrower values ('Smith','L-11');
insert into borrower values ('Williams','L-17');
insert into borrower values ('Adams','L-16');
insert into borrower values ('McBride','L-20');
insert into borrower values ('Smith','L-21');

insert into bank_news values ( 1 , 'New Perryridge branch' , 'The new Perryridge branch, in the city center, has opened today.');
insert into bank_news values ( 2 , 'Customer feedback' , 'Customers from the Brighton branch, located in the center of the city, have provided a great deal of positive feedback.');
insert into bank_news values ( 3 , 'New focus group' , 'Several Perryridge branch staff have been promoted to a skilled team who are focused on improving customer relations.');
insert into bank_news values ( 4 , 'New staff' , 'Several new staff members have been hired for the Brighton branch.');
insert into bank_news values ( 5 , 'Branch in Redwood' , 'New branch in Redwood is bringing us closer to clients in the area.');

delimiter //

drop function if exists total_balance //

create function total_balance(c varchar(255)) returns decimal(20,2)

begin
      declare credit decimal(20,2);
      declare debt decimal(20,2);

      select sum(balance) into credit
      from account natural join depositor
      where customer_name = c;

      if credit is null then set credit = 0;
      end if;

      select sum(amount) into debt
      from loan natural join borrower
      where customer_name = c;

      if debt is null then set debt = 0;
      end if;

      return credit-debt;
end//

delimiter ;
