--1: Without using max, find the year with the largest number of divorces
--order by followed by a limit
*For the next set of questions pay attention to what might happen if you have a year with NULL
values*

SELECT year, divorces FROM marriages
where divorces is not Null
ORDER BY divorces DESC
LIMIT 1;





--2: Find the change in population from year to year
with years_even_and_odd as(
select year, pop, mod(year,2) modulo
--where modulo != 0
from marriages
),

odd_years as(
select year, pop, modulo
from years_even_and_odd
where modulo != 0
),

even_years as(
select year, pop, modulo
from years_even_and_odd
where modulo != 1
)

select a.year, a.pop/b.pop
from odd_years a, even_years b;



--mod is a function where you divide two numbers and save the remainder
--3/2 = 1 remained 1
--4/2 = 2 remainder 0

P.S. The main idea is to break up your SQL queries into easily solvable components





--3: Find the ratio of marriages to divorces year by year (like 10:1 or 12:5 etc), you can use
the marriage/divorceX1000 statistic if you'd like
select marriagesx1000 / divorcesx1000 from marriages;





--4: What is the average marriage rate between 1900 and 1917?
--5 asks for between
select sum(marriages)/18 from marriages
where year between 1900 and 1917;
OR
select avg(marriages) from marriages
where year between 1900 and 1917;