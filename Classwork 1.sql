create table employee (
	id numeric (3,0),
	workername varchar,
	jobtitle varchar
);

insert into employee (id, workername, jobtitle) VALUES (123, 'jamie', 'boss');
insert into employee VALUES (432, 'Mordo', 'evil henchman');
insert into employee VALUES (666, 'benedict', 'super-visor');
insert into employee VALUES (1, 'zippy', 'founder');
insert into employee VALUES (2, 'guppy', 'local fish');

select * from employee;



create table mage (
	id numeric (3,0),
	type varchar,
	powerLevel numeric (5,0),
	schoolOfMind varchar
);

insert into mage (id, type, powerLevel, schoolOfMind) VALUES (123, 'fire', 99999, 'neutral-good');
insert into mage VALUES (432, 'dark', 67676, 'chaotic-evil');
insert into mage VALUES (666, 'sub-dark', 9001, 'neutral-evil');
insert into mage (id) VALUES (1);
insert into mage (id) VALUES (2);

select * from mage;



create table muggle (
	id numeric (3,0),
	mindSet varchar,
	discernibility numeric (4,2)
);

insert into muggle (id) VALUES (123);
insert into muggle VALUES (432);
insert into muggle VALUES (666);
insert into muggle (id, mindSet) VALUES (1, 'neurotic');
insert into muggle (id, discernibility) VALUES (2, .01);

select * from muggle;





# Update the table mage with a new row called belief with type varchar
alter table mage
add belief varchar;

# Update belief on tuple with id 666 on table mage with the value 'dogmatic'
update mage
set belief = 'dogmatic'
where id = 666;

# Delete the row with id 2 on the table muggle
delete from muggle where id = 2;

# Delete the row with id 3 on the table muggle
delete from muggle where id = 3;

# Delete the table muggle
drop table muggle;