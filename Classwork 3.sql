--1: 		Simple Statements:

--A:	How many employees are registered in the database?
select count(*) as Total from employee;


--B:	Which employees' first names start with the letter A (Using "like" code)
select fname from employee
where fname like 'A%';


--C:	What is the EID and full name of employees whose first and last names begin with A?
select eid, concat(fname, ' ', lname) as full_name from employee
where fname like 'A%' and lname like 'A%';

--last letter is an A
select eid, concat(fname, ' ', lname) as full_name from employee
where fname like '%A' or lname like '%A';
--both the first and last name's last letters are an A
select eid, concat(fname, ' ', lname) as full_name from employee
where upper(fname) like '%A' and upper(lname) like '%A';


--CI (wacky):	What is the average of the EIDs of C?
select avg (eid) from employee
where fname like 'A%' and lname like 'A%';





--2:		Building up to an inner join:

--A:	What are the cid's and names of each company?
select cid, name from companies;


--B:	What are the eid's and full names (hint: concatenate) of all employees?
select eid, concat(fname, ' ', lname) from employee;


--C:	What are the did's and eid's of all employees?
select did, eid from positions;


--D:	What are the full names, eid's and did's of all employees?
select
	concat(e.fname, ' ', e.lname),
	e.eid,
	p.did
	from employee e
inner join positions p 
	on e.eid = p.eid;

--playing a little: do some filter for fname starting with a or lname ending with o where DID is between 44-66
select
	concat(e.fname, ' ', e.lname),
	e.eid,
	p.did
	from employee e
inner join positions p 
	on e.eid = p.eid
	where p.did between 44 and 66 and (upper(e.fname) like 'A%' or upper(e.lname) like '%O');


--E:	What are the full names, eid''s, did''s of employees and what are the names and cid''s of companies?
select
	concat(e.fname, ' ', e.lname),
	e.eid,
	p.did,
	c.name,
	d.cid
	from employee e
inner join positions p 
	on e.eid = p.eid
inner join department d 
	on p.did = d.did
inner join companies c 
	on d.cid = c.cid;





--3:		Inner Joins:

--A:	What are the EIDs of employees in the company whose CID is 5?
select
	p.eid
	from positions p
inner join department d 
	on p.did = d.did
where d.cid = 5;


--B:	Which employees from A have an EID between (inclusive) 400 and 500?
select concat(fname, ' ', lname), eid from employee
where eid between 400 and 500
order by fname asc;


--C:	What is the average salary for people who are developers split by company?
select
	c.cid,
	c.name,
	ROUND(AVG(p.salary), 2) average_salary
	from positions p
inner join department d
	on d.did = p.did
inner join companies c
	on c.cid = d.cid
group by c.cid, c.name
order by cid asc;


--D:	How many employees have a position of 'contractor' in department 8?
select count('contractor') contractor_num from positions
where did = 8;


--ET (thinking): What would your output in D be if: 	

--we used did 117?
select count('contractor') contractor_num from positions
where did = 117;
							
--we used cid 19?
with connect_did_cid as(
select
	d.cid,
	p.did,
	p.title
	from positions p
inner join department d
	on d.did = p.did
order by title, cid asc
)

select count(*) contractor_num from connect_did_cid
where title = 'contractor' and cid = 19;
							
--we used cid 3 and did 55?
with connect_did_cid as(
select
	d.cid,
	p.did,
	p.title
	from positions p
inner join department d
	on d.did = p.did
order by title, cid, did asc
)

select count(*) contractor_num from connect_did_cid
where title = 'contractor' and cid = 3 and did = 55;





--4:		More practice:

--A:	What is the average salary each department pays for its employees?
select
	d.dept,
	ROUND(AVG(p.salary), 2) average_salary
	from positions p
inner join department d
	on d.did = p.did
group by d.dept
order by dept asc;


--B:	Which department pays the maximum average salary (only output that department)
with avg_salary_dep as(
select
	d.dept,
	ROUND(AVG(p.salary), 2) average_salary
	from positions p
inner join department d
	on d.did = p.did
group by d.dept
order by dept asc
)

select dept as max_salary_dept from avg_salary_dep
order by average_salary desc limit 1;


--C:	How many employees does each company have?
select
	c.cid,
	c.name,
	COUNT (p.eid) total_employee
	from positions p
inner join department d
	on d.did = p.did
inner join companies c
	on c.cid = d.cid
group by c.cid, c.name
order by cid asc;


--D:	How many employees per department does each company have?
select
	c.cid,
	c.name,
	d.dept,
	COUNT (p.eid) as emp_per_dep
	from positions p
inner join department d
	on d.did = p.did
inner join companies c
	on c.cid = d.cid
group by c.cid, c.name, d.dept
order by cid asc;


--E:	How much does each company pay in total salaries?
select
	c.cid,
	c.name,
	SUM (p.salary) as total_salary
	from positions p
inner join department d
	on d.did = p.did
inner join companies c
	on c.cid = d.cid
group by c.cid, c.name
order by cid asc;





--5:		Food!>?: (this is a harder problem set)
--Premise:	Your company had a great earnings report and they're too cheap to give bonuses. Instead they decide to host a party.

--A:	What are the full names of employees who don't have a favorite food?
select
	e.eid,
	concat(e.fname, ' ', e.lname)
	from employee e
inner join foodies f
	on f.eid = e.eid
where favfood is NULL
order by eid asc;


--B:	What are the number of employees each food category has?
select
	f.favfood,
	COUNT(e.eid) as emp_per_food
	from employee e
inner join foodies f
	on f.eid = e.eid
group by f.favfood
order by favfood asc;


--C:	The company realizes that too many employees have different preferences and they can't host a party for everyone...instead they decide to choose the three most popular foods and have a party just for those employees. What are the 3 favorite foods of employees in company 3?
with food_and_company as(
select
	d.cid,
	f.favfood,
	COUNT(p.eid) as emp_per_food
	from foodies f
inner join positions p
	on p.eid = f.eid
inner join department d
	on d.did = p.did
group by d.cid, f.favfood
order by cid, emp_per_food desc
)

select favfood as the_most_favorite_foods_in_company_3 from food_and_company
where cid = 3
order by emp_per_food desc limit 3;



-- Addition:
select
	d.cid,
	f.favfood,
	COUNT(p.eid) as emp_per_food
	from foodies f
inner join positions p
	on p.eid = f.eid
inner join department d
	on d.did = p.did
where d.cid = 3
group by d.cid, f.favfood
order by emp_per_food desc
limit 3;


--	CI:	The company realizes that this would be unfair to many employees so they call other companies (the ones in our database) and each decides to host a party with their employees favorite foods and invite employees who like that food to their company feast as well.
with food_and_company as(
select
	d.cid,
	f.favfood,
	COUNT(p.eid) as emp_per_food
	from foodies f
inner join positions p
	on p.eid = f.eid
inner join department d
	on d.did = p.did
group by d.cid, f.favfood
order by cid, emp_per_food desc
)

select * from food_and_company a
where (select COUNT(*) from food_and_company b
where b.cid = a.cid AND b.emp_per_food >= a.emp_per_food
) <=3;


--	CII:	What is wrong with this idea?
--Answer: This is a bad idea because some companies do not have the favorite foods of their employees. Also, in my opinion, the output is not really useful and significant.
Some companies might have the same favorite food, not all of the foods would be considered.


--	CIII:	Which employees not in company 3 should be invited to company 3's party?
with food_and_company as(
select
	d.cid,
	f.favfood,
	COUNT(p.eid) as emp_per_food
	from foodies f
inner join positions p
	on p.eid = f.eid
inner join department d
	on d.did = p.did
group by d.cid, f.favfood
order by cid, emp_per_food desc
),
eid_n_cid as(
select
	d.cid,
	p.eid,
	concat(fname, ' ', lname) as name,
	f.favfood
	from department d
inner join positions p
	on p.did = d.did
inner join employee e
	on e.eid = p.eid
inner join foodies f
	on f.eid = e.eid
group by d.cid, p.eid, name, f.favfood
order by cid, favfood
)

select cid, eid, name from eid_n_cid
where cid !=3 and favfood IN (select favfood as fav_foods_in_comp_3 from food_and_company
where cid = 3
order by emp_per_food desc limit 3)
order by cid, eid;



-- Addition:
select
	d.cid,
	f.favfood,
	p.eid,
	from foodies f
inner join positions p
	on p.eid = f.eid
inner join department d
	on d.did = p.did
where d.cid != 3 and 1 = CASE
	when f.favfood like 'Pizza' then 1
	when f.favfood like 'Ribs' then 1
	when f.favfood like 'Cronut' then 1
	else 0
end;