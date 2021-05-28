# Name: Yun-Ting Tsai
# Assignment 3
# Date: 03/11/21

-- Q1:

-- a.	What is SQL and what is it used for?
-- SQL (AKA Sequential Query Language) is composed by CRUD operations, namely Create (a table), Read (select and view data), Update (change a row in a table), and Delete (delete a row in a table).

-- b.	What is a DBMS (like postgres) and what does it do?
-- DBMS (AKA Database Management System) is used to communicate a database with SQL.

-- c.	What is DDL and what is DML? Also which types of data does each apply to?
-- DDL (AKA Data Definition Language) is to define data structures. Ex: Create table, Alter table.
-- DML (AKA Data Manipulation Language) is to manipulate data itself. Ex: Insert (Adding), Update (Modifying), Delete.





-- Q2:

-- a.	Write the code to create a table named people with the following columns: id, name, email, DOB, city, ZIP and state. Drop any table called people before making this table.

drop table people;

create table people (
	id int,
	name varchar,
	email varchar,
	DOB date,
	city varchar,
	ZIP int,
	state varchar
);


-- b.	Write the code that inserts full rows (funny names preferred) into this table. Insert 3 different rows and print the output here.

insert into people (id, name, email, DOB, city, ZIP, state) VALUES (1, 'Sherlock', 'sherlockholmes@gmail.com', '1976-07-19', 'London', 11111, 'New York');
insert into people (id, name, email, DOB, city, ZIP, state) VALUES (2, 'Mycroft', 'mycroftholmes@gmail.com', '1966-10-17', 'Sedgefield', 22222, 'California');
insert into people (id, name, email, DOB, city, ZIP, state) VALUES (3, 'Eurus', 'eurusholmes@gmail.com', '1980-04-18', 'Lichfield', 33333, 'Mississippi');

select * from people;


-- c.	Alter people to also include a column called street number.

alter table people
add street numeric; 


-- d.	Update the individual who's id is 2 and change his city to Tokyo.

update people
set city = 'Tokyo'
where id = 2;

-- Why this is a bad idea?
-- Answer: Because this will change the order of results/output, and then the table will be difficult to read.


-- e.	Count the number of people in the table.

select count(*) as Total from people;

-- Is it better to create a view here or to run the SQL code? 
-- Answer: Yes, this is better for us to create a view and run the code because the result can tell us how many rows of data we have so that we can easily do some records or investigations for further analysis.


-- f.	Find the oldest person and the youngest person in the table. 

select min(DOB) as Oldest, max(DOB) as Youngest from people;


-- g.	Who lives in Brooklyn NY?
select name from people
where city like 'Brooklyn';


-- h.	Delete the person who is not the oldest and not the youngest.

delete from people
where DOB > (select min(DOB) from people limit 1) and DOB < (select max(DOB) from people limit 1);





-- Q3:

-- a.	Alter people and drop the column called state.

alter table people
drop state;


-- i.	Write the code to create a new table that can query zip codes and provide the state associated with the code.

create table zipNstate (
	ZIP int,
	state varchar
);


-- ii.	Is normalization a good idea?
-- Answer: Yes, normalization is a good idea because we can easily use primary keys to connect or join data between tables.