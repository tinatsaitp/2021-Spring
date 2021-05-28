CREATE TABLE users(
	userId INT,
	userName varchar,
	userAgeRange varchar,
	userGender varchar,
	userInterests varchar,
	usageTime varchar,
	companyId INT
);

\copy users(userId,userName,userAgeRange,userGender,userInterests,usageTime, companyId) FROM '*insert spreadsheet path here*' DELIMITER ',' CSV HEADER

select * from users;



CREATE TABLE companies(
	companyId INT,
	companyName varchar,
	headquarter varchar,
	revenue varchar,
	founded date,
	userAmount varchar
);

insert into companies(companyId, companyName, headquarter, revenue, founded, userAmount) VALUES (1, 'Facebook', 'Menlo Park, CA, US', '86 B', '2004-02-04', '2.8 B');
insert into companies VALUES (2, 'Instagram', 'Menlo Park, CA, US', '12 B', '2010-10-6', '815 M');
insert into companies VALUES (3, 'Snapchat', 'Santa Monica, CA, US', '2.5 B', '2011-09-16', '265 M');
insert into companies VALUES (4, 'Tiktok', 'Culver City, CA, US', '1 B', '2016-09-01', '500 M');
insert into companies VALUES (5, 'Twitter', 'San Francisco, CA, US', '3.7 B', '2006-03-21', '187 M');
insert into companies VALUES (6, 'Youtube', 'San Bruno, CA, US', '19.8 B', '2005-02-14', '2.3 B');

select * from companies;



CREATE TABLE ad(
	adId varchar,
	companyId INT,
	adType varchar,
	adFormat varchar
);

\copy ad(adId,companyId,adType,adFormat) FROM '*insert spreadsheet path here*' DELIMITER ',' CSV HEADER

select * from ad;





--1) Which time intervals do users use social media the most?
-- Counts of all time intervals
select
	usageTime,
	count(*)
	from users
Group by usageTime
Order by count(*) DESC;

-- The time interval most frequently used by users
select
	usageTime,
	count(*)
	from users
Group by usageTime
Order by count(*) DESC limit 1;





--2) Which ad type and format should each company put on their platform to attract the largest audience?
	--The 1st & 2nd output table (the entire table will be too long, so our group divides it into 2 separate tables) will show the ad type counts for each company
	--The 3rd output table will show the ad format counts for each company
	--The largest number in each row is the ad type/format that each company should apply

-- ad type count for each company part 1
select
sum(case when adType like '%Gaming%' then 1 else 0 end) AS gamesCount,
sum(case when adType like '%Animals%' then 1 else 0 end) AS animalsCount,
sum(case when adType like '%Sports%' then 1 else 0 end) AS sportsCount,
sum(case when adType like '%Arts%' then 1 else 0 end) AS artsCount,
sum(case when adType like '%Music%' then 1 else 0 end) AS musicCount,
sum(case when adType like '%Food%' then 1 else 0 end) AS foodCount,
sum(case when adType like '%Makeup%' then 1 else 0 end) AS makeupCount,
sum(case when adType like '%Travel%' then 1 else 0 end) AS travelCount,
sum(case when adType like '%Media%' then 1 else 0 end) AS mediaCount,
sum(case when adType like '%Films%' then 1 else 0 end) AS filmsCount,
sum(case when adType like '%Novels%' then 1 else 0 end) AS novelsCount,
sum(case when adType like '%Comic%' then 1 else 0 end) AS comicsCount,
c.companyName
from ad a
inner join companies c ON
c.companyId = a.companyId
group by c.companyId,c.companyName;

-- ad type count for each company part 2
select
sum(case when adType like '%Cars%' then 1 else 0 end) AS carCount,
sum(case when adType like '%Education%' then 1 else 0 end) AS educationCount,
sum(case when adType like '%Science%' then 1 else 0 end) AS scienceCount,
sum(case when adType like '%Social services%' then 1 else 0 end) AS socialservicesCount,
sum(case when adType like '%Job%' then 1 else 0 end) AS jobCount,
sum(case when adType like '%Business%' then 1 else 0 end) AS businessCount,
sum(case when adType like '%languages%' then 1 else 0 end) AS languagesCount,
sum(case when adType like '%sponsored%' then 1 else 0 end) AS sponsoredAdsCount,
sum(case when adType like '%Marketing%' then 1 else 0 end) AS marketingCount,
sum(case when adType like '%Others%' then 1 else 0 end) AS othersCount,
sum(case when adType like '%None%' then 1 else 0 end) AS noneCount,
c.companyName
from ad a
inner join companies c ON
c.companyId = a.companyId
group by c.companyId,c.companyName;

-- ad format count for each company
select
sum(case when adFormat like '%Pop-up%' then 1 else 0 end) AS PopupCount,
sum(case when adFormat like '%Banner%' then 1 else 0 end) AS BannerCount,
sum(case when adFormat like '%Skip%' then 1 else 0 end) AS SkipAdCount,
sum(case when adFormat like '%Sponsored%' then 1 else 0 end) AS SponsoredPostCount,
sum(case when adFormat like '%Others%' then 1 else 0 end) AS OthersCount,
c.companyName
from ad a
inner join companies c ON
c.companyId = a.companyId
group by c.companyId,c.companyName;