--B1. Write the SQL needed to create ALL THREE tables. 

create table actor(
	ActID varchar, 
	ActName varchar, 
	ActSex char(1)
);
insert into actor(ActID, ActName, ActSex) VALUES('M61', 'Marilyn Monroe', 'F');
insert into actor(ActID, ActName, ActSex) VALUES('H876', 'Tom Hanks', 'M');
insert into actor(ActID, ActName, ActSex) VALUES('K1', 'Kim Nam-gil', 'M');
insert into actor(ActID, ActName, ActSex) VALUES('K28', 'Kim Young-ae', 'F');
insert into actor(ActID, ActName, ActSex) VALUES('RG6', 'Ryan Gosling', 'M');
insert into actor(ActID, ActName, ActSex) VALUES('ES32', 'Emma Stone', 'F');



create table movie(
	MovieID varchar, 
	MovieName varchar,  
	MovieYR int,
	MovieRating varchar
);
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('M654', 'Godfather', 1995, 'PG');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('R321', 'The Rock', 2003, 'PG13');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('S876', 'Skyfall', 2011, 'R');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('SN12', 'Snow White', 1944, 'G');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('DT', 'Donald Trump', 2018, '??');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('M10', 'Some Like It Hot', 1959, 'PG');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('DVC1', 'The Da Vinci Code', 2006, 'PG13');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('DVC2', 'Angels & Demons', 2009, 'PG13');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('DVC3', 'Inferno', 2016, 'PG13');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('DC18', 'La La Land', 2016, 'PG13');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('JWP389', 'Pandora', 2016, '??');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('M4', 'Niagara', 1953, 'PG');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('M6', 'Gentlemen Prefer Blondes', 1953, 'U');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('M5', 'How to Marry a Millionaire', 1953, 'PG');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('DOC567', 'California typewriter', 2016, 'TV-PG');


create table MA(
	MovieID varchar, 
	ActID varchar, 
	Salary numeric (15,2)
);
insert into MA(MovieID, ActID, Salary) VALUES('M10', 'M61', 4500000);
insert into MA(MovieID, ActID, Salary) VALUES('M4', 'M61', 3100000);
insert into MA(MovieID, ActID, Salary) VALUES('M5', 'M61', 2900000);
insert into MA(MovieID, ActID, Salary) VALUES('M6', 'M61', 3800000);
insert into MA(MovieID, ActID, Salary) VALUES('DVC1', 'H876', 18000000);
insert into MA(MovieID, ActID, Salary) VALUES('DVC2', 'H876', 50000000);
insert into MA(MovieID, ActID, Salary) VALUES('DVC3', 'H876', 65000000);
insert into MA(MovieID, ActID, Salary) VALUES('JWP389', 'K1', 32000000);
insert into MA(MovieID, ActID, Salary) VALUES('JWP389', 'K28', 23000000);
insert into MA(MovieID, ActID, Salary) VALUES('DC18', 'RG6', 46000000);
insert into MA(MovieID, ActID, Salary) VALUES('DC18', 'ES32', 39000000);
insert into MA(MovieID, ActID, Salary) VALUES('DOC567', 'H876', 9000000);


select * from actor;
select * from movie;
select * from MA;





--B2. Write the SQL needed to insert the following data into these tables. Actor W323 John Wayne is a male who acted in the 1954 movie R34 Rio Grande which was G rated and earned $200,000. 

insert into actor(ActID, ActName, ActSex) VALUES('W323', 'John Wayne', 'M');
insert into movie(MovieID, MovieName, MovieYR, MovieRating) VALUES('R34', 'Rio Grande', 1954, 'G');
insert into MA(MovieID, ActID, Salary) VALUES('R34', 'W323', 200000);





--B3. I want to determine if MALE actors were paid more than FEMALE actors in 2016.  Write the SQL to determine the average salary of the MALE actors who appeared in movies made in 2016. 

select
	ActSex,
	round(avg(Salary),2)
	from MA ma
inner join actor a 
	on a.ActID = ma.ActID
inner join movie m 
	on m.MovieID = ma.MovieID
where ActSex like 'M' and MovieYR = 2016
group by ActSex;





--B4. Write the SQL needed to list the names of ACTORS who did not appear in any movie made in 2016.

select ActName from actor
where ActName NOT IN
(select
	ActName
	from actor a
inner join MA ma 
	on ma.ActID = a.ActID
inner join movie m 
	on m.MovieID = ma.MovieID
where MovieYR = 2016);





--B5. Write the SQL needed to determine the number of movies made by rating for 2016.  For example,  G 410     PG 123   PG13 874  R 201  ?? 2 

select MovieRating, count(MovieRating) from movie
where MovieYR = 2016
group by MovieRating
order by MovieRating;





--B6. Write the SQL needed to list the name of the female actor who made the most money in 2016.  This is tricky.  This female actor could have been in multiple movies. 

--List all female actor in 2016
select
	ActName,
	sum(Salary) as Total_Salary
	from actor a
inner join MA ma 
	on ma.ActID = a.ActID
inner join movie m 
	on m.MovieID = ma.MovieID
where ActSex like 'F' and MovieYR = 2016
group by ActName
order by sum(Salary) desc;

--The name of the female actor who made the most money in 2016
select
	ActName,
	sum(Salary) as Total_Salary
	from actor a
inner join MA ma 
	on ma.ActID = a.ActID
inner join movie m 
	on m.MovieID = ma.MovieID
where ActSex like 'F' and MovieYR = 2016
group by ActName
order by sum(Salary) desc limit 1;





--B7. All the data for actor DT1 was entered into the tables. DT1 acted in many movies. We want to erase all the information about DT1. Any movie that DT1 appeared in also has to be erased. Write the SQL needed for this. 

--Delete from actor table
delete from actor where ActID like 'DT1';

--Delete from movie table
delete from movie
where MovieID in(
select 
	MovieID
from MA
where ActID like 'DT1');

--Delete from MA table
delete from MA where ActID like 'DT1';





--B8. Create a view called MM containing the name and year of each movie made by actor M61.  In addition, the view must contain the salary earned by M61 for each movie. Using the view MM created, list the movie names in year order. 

create view MM as
select
	MovieName,
	MovieYR,
	Salary
	from MA ma 
inner join movie m 
	on m.MovieID = ma.MovieID
where ActID = 'M61'
order by MovieYR;





--B9. A new law has been passed that no ACTOR can appear in more than 100 movies. What can you do to enforce this restriction?

select 
	ActID,
	count(MovieID) as Movie_Sum,
CASE
	WHEN count(MovieID) > 100 THEN 'Exceed the Limit'
	ELSE 'Can Still Appear In Movies'
END as Status,
CASE
	WHEN count(MovieID) > 100 THEN 0
	ELSE 100-count(MovieID)
END as Number_Of_Remaining_Movies
	from MA
group by ActID
order by ActID;