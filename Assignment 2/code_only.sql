CREATE TABLE schoolInfor(
	schoolId INT,
	schoolName varchar,
	builtTime INT,
	address varchar,
	campus BOOLEAN, --TRUE: Urban --FALSE: Rural
	type BOOLEAN, --TRUE: Public --FALSE: Private
	tuition numeric (10,2),
	gradRate numeric (4,2),
	dropoutRate numeric (4,2),
	transferredRate numeric (4,2),
	president varchar,
	motto varchar,
	website varchar,
	ranking numeric (6)
);

CREATE TABLE departmentInfor(
	departmentId INT,
	title varchar,
	major BOOLEAN,
	minor BOOLEAN,
	financialAid BOOLEAN
);

CREATE TABLE enrollmentInfor(
	studentId INT,
	studentName varchar,
	email varchar,
	phone numeric (10),
	major varchar,
	minor varchar,
	ethnicity varchar,
	gender varchar,
	DOB varchar,
	grade varchar,
	GPA numeric (3,2),
	credits numeric (3),
	job BOOLEAN,
	liveNY BOOLEAN,
	familyWage numeric (8),
	financialAid BOOLEAN
);

CREATE TABLE clubInfor(
	clubId INT,
	title varchar,
	type varchar,
	location varchar,
	advisor varchar,
	countMember numeric (4)
);

CREATE TABLE SchoolToDepartment (
	schoolId INT,
	departmentId INT
);

CREATE TABLE DepartmentToStudent (
	departmentId INT,
	studentId INT
);

CREATE TABLE StudentToClub (
	studentId INT,
	clubId INT
);





insert into schoolInfor(schoolId, schoolName, builtTime, address, campus, type, tuition, gradRate, dropoutRate, transferredRate, president, motto, website, ranking) VALUES (1, ‘Laguna Beach University’, 1900, ‘153 Stadium Drive, Cambridge, MA 02141’, TRUE, TRUE, 10000, 84.5, 23.1, 20.1, ‘Leyton Bloggs’, ‘Mihi cura futuri’, ‘lagunabeachu.com’, 100);

select * from schoolInfor;



insert into departmentInfor(departmentId, title, major, minor, financialAid) VALUES (1, ‘Computer Science’, TRUE, TRUE, TRUE);

insert into departmentInfor VALUES (2, ‘Math and Statistics’, TRUE, TRUE, FALSE);

insert into departmentInfor VALUES (3, ‘Psychology’, TRUE, FALSE, TRUE);

select * from departmentInfor;



insert into enrollmentInfor (studentId, studentName, email, phone, major, minor, ethnicity, gender, DOB, grade, GPA, credits, job, liveNY, familyWage, financialAid) VALUES (1, 'Ethan', 'ethan@laguna.com', 2225441968, 'Computer Science', 'Media Studies', 'White', 'Male', 'October 11th 2001', 'Sophomore', 3.5, 60, FALSE, TRUE, 85000, TRUE);

insert into enrollmentInfor VALUES (2, 'Mary', 'mary@laguna.com', 7651235555, 'Computer Science', 'Math', 'African-American', 'Female', 'November 10th 1998', 'Senior', 3.7, 95, TRUE, FALSE, 92000, FALSE);

insert into enrollmentInfor VALUES (3, 'John', 'john@laguna.com', 6465559128, 'Computer Science', 'Anthropology', 'Latino', 'Male', 'March 15th 2000', 'Junior', 3.4, 75, FALSE, TRUE, 76000, TRUE);

insert into enrollmentInfor VALUES (4, 'Tushar', 'tushar@laguna.com', 3672987412, 'Statistics', 'None', 'Asian', 'Male', 'April 3rd 1999', 'Senior', 3.55, 105, TRUE, TRUE, 102000, FALSE);

insert into enrollmentInfor VALUES (5, 'Isabella', 'isabella@laguna.com', 6397223456,'Mathematics', 'Art History', 'Native American', 'Female', 'August 31st 2002', 'Freshman', 3.35, 15, FALSE, FALSE, 97000, FALSE);

insert into enrollmentInfor VALUES (6, 'Yun-Ting', 'yun-ting@laguna.com', 9176643890, 'Psychology', 'Sociology’, 'Asian', 'Female', 'January 13th 2001', 'Sophomore', 3.65, 54, TRUE, TRUE, 125000, FALSE);

insert into enrollmentInfor VALUES (7, 'Zhongwei', 'zhongwei@laguna.com', 8008888888, 'Psychology', 'History', 'Asian', 'Male', 'June 16th 2000', 'Junior', 3.5, 80, TRUE, FALSE, 2000, TRUE);

select * from enrollmentInfor;



insert into clubInfor(clubId,title,type,location,advisor,countMember) VALUES (1, 'Basketball', 'Sports', 'Room 231', 'Professor Carlos', 2);

insert into clubInfor(clubId,title,type,location,advisor,countMember) VALUES (2, 'Acapella', 'Music', 'Room 351', 'Professor Leslie', 4);

insert into clubInfor(clubId,title,type,location,advisor,countMember) VALUES (3, 'Fashion Design', 'Arts', 'Room 541', 'Professor Justin', 3);

select * from clubInfor;



INSERT INTO SchoolToDepartment VALUES(1, 1);
INSERT INTO SchoolToDepartment VALUES(1, 2);
INSERT INTO SchoolToDepartment VALUES(1, 3);

INSERT INTO DepartmentToStudent VALUES(1, 1);
INSERT INTO DepartmentToStudent VALUES(1, 2);
INSERT INTO DepartmentToStudent VALUES(1, 3);
INSERT INTO DepartmentToStudent VALUES(2, 4);
INSERT INTO DepartmentToStudent VALUES(2, 5);
INSERT INTO DepartmentToStudent VALUES(3, 6);
INSERT INTO DepartmentToStudent VALUES(3, 7);

INSERT INTO StudentToClub VALUES(1, 1);
INSERT INTO StudentToClub VALUES(1, 2);
INSERT INTO StudentToClub VALUES(1, 3);
INSERT INTO StudentToClub VALUES(2, 1);
INSERT INTO StudentToClub VALUES(3, 2);
INSERT INTO StudentToClub VALUES(3, 3);
INSERT INTO StudentToClub VALUES(4, 2);
INSERT INTO StudentToClub VALUES(5, 2);
INSERT INTO StudentToClub VALUES(6, 3);