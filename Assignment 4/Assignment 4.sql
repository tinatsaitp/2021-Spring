create table alcohol(
	school varchar(2),
	sex char,
	age numeric,
	address char,
	famsize varchar(3),
	sep char,
	Medu numeric,
	Fedu numeric,
	Mjob varchar,
	Fjob varchar,
	reason varchar, --why they chose this school
	guardian varchar,
	traveltime numeric,
	studytime numeric,
	failures numeric,
	schoolsup varchar,
	famsup varchar,
	paid varchar, --advanced classes
	ec varchar, --extra curricular
	preschool varchar,
	college varchar, --called higher in dataset
	internet varchar,
	dating varchar, --called romantic in dataset,
	famrel numeric,
	freetime numeric,
	goout numeric,
	dailyalc numeric,
	weekendalc numeric,
	health numeric,
	absences numeric,
	G1 numeric,
	G2 numeric,
	Final numeric
);

\copy alcohol(school, sex, age, address, famsize, sep, Medu, Fedu, Mjob, Fjob, reason, guardian, traveltime, studytime, failures, schoolsup, famsup, paid, ec, preschool, college, internet, dating, famrel, freetime, goout, dailyalc, weekendalc, health, absences, G1, G2, final) FROM '*insert spreadsheet path here*' DELIMITER ',' CSV HEADER





--Q1: What is the number of parents living together? What is the number of parents living apart?
--Aggregate Window Functions: COUNT()

select sep, count(sep) from alcohol
group by sep;



--Q2: What is the average of the number of school absences?
--Aggregate Window Functions: AVG()

select 
	round(avg(absences),2) as Absence_Avg
from alcohol;



--Q3: What is the ratio between the average of mothers’ education and the average of fathers’ education?
--Aggregate Window Functions: AVG()
--Math: Division 

select 
	round(avg(medu), 2) as Mother_Edu_Avg, 
	round(avg(fedu), 2) as Father_Edu_Avg,
	round(avg(medu) / avg(fedu), 2) as Ratio
from alcohol;



--Q4: What is the difference between the highest(max) grade and the lowest(min) grade in the 1st-period grade, the 2nd-period grade, and the final grade?
--Aggregate Window Functions: MAX(), MIN()
--Math: Subtraction

--1st-period grade
select 
	max(G1) as Highest_Grade,
	min(G1) as Lowest_Grade,
	max(G1)-min(G1) as Difference
from alcohol;

--2nd-period grade
select 
	max(G2) as Highest_Grade,
	min(G2) as Lowest_Grade,
	max(G2)-min(G2) as Difference
from alcohol;

--Final grade
select 
	max(Final) as Highest_Grade,
	min(Final) as Lowest_Grade,
	max(Final)-min(Final) as Difference
from alcohol;