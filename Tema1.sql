create table Organizations (
	org_code int primary key,
	org_name varchar(50),
	hq varchar(50),
	founded_date date
);

create table Countries (
	country_code int primary key,
	country_name varchar(50),
	capital varchar(50),
	area float,
	population_count float,
	continent varchar(50)
);

create table CountryOrg (
	org_code int foreign key references Organizations (org_code),
	country_code int foreign key references Countries (country_code),
	constraint country_org_pk primary key (org_code,country_code)
);

insert into Organizations (org_code, org_name, hq, founded_date) values
(1,'NATO','Bruxelles','1949-04-04'),
(2,'APEC','Queenstown','1989-01-01');

select* from Organizations;

insert into Countries (country_code, country_name, capital, area, population_count, continent) values
(1,'Romania','Bucharest',238.397,20.121,'Europe'),
(2,'Italy','Rome',301.230,60.317,'Europe'),
(3,'United States','Washington',9629.091,331.449,'North America'),
(4,'Spain','Madrid',505.370,46.733,'Europe'),
(5,'Portugal','Lisbon',92.212,20,'Europe'),
(6,'Poland','Warsaw',312.696,38.179,'Europe'),
(7,'Germany','Berlin',357.121,80.399,'Europe'),
(8,'France','Paris',674.843,67.063,'Europe'),
(9,'Canada','Ottawa',9984.670,38.526,'North America'),
(10,'Belgium','Bruxelles',30.528,11.071,'Europe'),
(11,'Australia','Canberra',7692.024,25.967,'Oceania'),
(12,'New Zealand','Wellington',268.021,5.134,'Oceania'),
(13,'China','Beijing',9595.961,1412.6,'Asia'),
(14,'Mexico','Mexico City',1972.55,126.014,'North America'),
(15,'Chile','Santiago',756.096,17.574,'South America'),
(16,'Japan','Tokyo',377.975,125.44,'Asia'),
(17,'Russia','Moscow',17098.246,145.478,'Asia');

insert into CountryOrg (org_code, country_code) values
(1,1),
(1,2),
(1,3),(2,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),(2,9),
(1,10),
(2,11),
(2,12),
(2,13),
(2,14),
(2,15),
(2,16),
(2,17);

-- 1.List all countries members of NATO
select C.country_name, O.org_name from Countries C 
inner join CountryOrg CO on C.country_code = CO.country_code
inner join Organizations O on O.org_code = CO.org_code
where O.org_name like 'NATO';

-- 2.List all countries members of organizations founded before 1980
select C.country_name, O.org_name, O.founded_date from Countries C 
inner join CountryOrg CO on C.country_code = CO.country_code
inner join Organizations O on O.org_code = CO.org_code
where O.founded_date < '1980-01-01';

-- 3.List all the countries which are members of only one organization
select C.country_name from Countries C 
inner join CountryOrg CO on C.country_code = CO.country_code
inner join Organizations O on O.org_code = CO.org_code
group by C.country_name
having count(CO.country_code) <= 1;

-- 4.List all the capitals which are headquarter of no organization
select C.capital from Countries C 
inner join CountryOrg CO on C.country_code = CO.country_code
inner join Organizations O on O.org_code = CO.org_code
where C.capital not like O.hq
group by C.capital;

-- 5.List the population of each continent
select C.continent, sum(C.area) as Area from Countries C 
inner join CountryOrg CO on C.country_code = CO.country_code
inner join Organizations O on O.org_code = CO.org_code
group by C.continent;

-- 6.Count the countries of each continent
select C.continent, count(C.country_name) as NrCountries from Countries C 
inner join CountryOrg CO on C.country_code = CO.country_code
inner join Organizations O on O.org_code = CO.org_code
group by C.continent;