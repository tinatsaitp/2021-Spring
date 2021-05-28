create table covidSurvey(
	id varchar,
	regionOfResidence varchar,
	ageOfSubject INT,
	timeSpentOnOnlineClass numeric,
	ratingOfOnlineClassExperience varchar,
	mediumForOnlineClass varchar,
	timeSpentOnSelfStudy numeric,
	timeSpentOnFitness numeric,
	timeSpentOnSleep numeric,
	timeSpentOnSocialMedia numeric,
	preferredSocialMediaPlatform varchar,
	timeSpentOnTv numeric,
	numberOfMealsPerDay INT,
	changeInWeight varchar,
	healthIssueDuringLockdown BOOLEAN,
	stressBusters varchar,
	timeUtilized BOOLEAN,
	moreConnectionWithFamilyCloseFriendsOrRelatives BOOLEAN,
	missTheMost varchar
);

\copy covidSurvey (id,regionOfResidence,ageOfSubject,timeSpentOnOnlineClass,ratingOfOnlineClassExperience,mediumForOnlineClass,timeSpentOnSelfStudy,timeSpentOnFitness,timeSpentOnSleep,timeSpentOnSocialMedia,preferredSocialMediaPlatform,timeSpentOnTv,numberOfMealsPerDay,changeInWeight,healthIssueDuringLockdown,stressBusters,timeUtilized,moreConnectionWithFamilyCloseFriendsOrRelatives,missTheMost) FROM '*insert spreadsheet path here*' DELIMITER ',' CSV HEADER

select * from covidSurvey;





--Q1: How do the time spent on fitness and the number of meals per day affect the weight of the interviewee?

--During the pandemic, if the student eats more meals but does less exercise, and his/her weight is increasing, then this shows that the time spent on fitness and the number of meals per day will affect people’s weight.
--During the pandemic, if the student eats fewer meals but does more exercise, and his/her weight is decreasing, then this shows that the time spent on fitness and the number of meals per day will affect people’s weight.
--Otherwise, other answers show that the time spent on fitness and the number of meals per day will NOT affect people’s weight.

SELECT id, timeSpentOnFitness, numberOfMealsPerDay, changeInWeight,
CASE
	WHEN timeSpentOnFitness < numberOfMealsPerDay AND changeInWeight = 'Increased' THEN 'YES'
	WHEN timeSpentOnFitness > numberOfMealsPerDay AND changeInWeight = 'Decreased' THEN 'YES'
	ELSE 'NO'
END AS Do_Fitness_Time_And_Number_Of_Meals_Affect_The_Weight 
FROM covidSurvey;



--Q2: What is the ratio of the time spending on social media and TV to online classes and self-study for each interviewee?

--If the answer is less than 1, this means that the student is more hard-working.
--In contrast, if the answer is more than 1, this means that the student spends more time on leisure activities.

SELECT id, timeSpentOnSocialMedia, timeSpentOnTv, timeSpentOnOnlineClass, timeSpentOnSelfStudy, round(((timeSpentOnSocialMedia + timeSpentOnTv) / NULLIF((timeSpentOnOnlineClass + timeSpentOnSelfStudy), 0)), 2) as Ratio FROM covidSurvey;



--Q3: How does the health issue relate to each interviewee finding themselves more connected with their family, close friends, and relatives?

--If “Health issue during lockdown” = “Do you find yourself more connected with your family, close friends, and relatives”, this means that the connection with family, close friends, and relatives will affect the health of the student.

SELECT id, moreConnectionWithFamilyCloseFriendsOrRelatives, healthIssueDuringLockdown,
CASE
	WHEN moreConnectionWithFamilyCloseFriendsOrRelatives = healthIssueDuringLockdown THEN 'YES'
	ELSE 'NO'
END AS Does_The_Connection_With_Others_Affect_The_Health_Issue
FROM covidSurvey;