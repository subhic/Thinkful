--Q1:  How many records are in the vehicles table?
--Provide the query you’d use to determine this as well as the answer to the question.

select count(*) from vehicles;
-- 33442 rows

-- Q2: Write a query that returns all the records in the vehicles table.
select * from vehicles;

-- Q3 Write a query that returns the id, make, and model fields for all the records for 2010 vehicles.

select id, make, model
from vehicles
where year = '2010';

-- Q4 Write a query that returns the count of vehicles from 2010. Also provide the answer
select count(*) 
from vehicles where year >= 2010;
--Answer: 5995

-- Q5 Write a query that returns the count of vehicles in the vehicles table between
-- the years 2010 and 2015, inclusive. Provide the query as well as the answer.

select count(*)
from vehicles
where year between 2010 and 2015;
-- Answer: 5995

--Q6 Write a query that returns the count of vehicles from the years 1990, 2000, and 2010.
-- Provide the query and the result.

select count(*),year
from vehicles
where year IN ('1990','2000','2010')
group by year;



-- Q7 Write a query that returns the count of all records between 1987 and 2005, 
--exclusive of the years 1990 and 2000.
select count(*),year
from vehicles 
where year NOT IN ('1990','2000')
group by year
order by year desc;

-- Q8 Write a query that returns the year, make, model, and a field called
-- average_mpg that calculates the average highway/city fuel consumption.
-- (For example, if hwy is 24 and cty is 20, then average_mpg = (24 + 20)/ 2 = 22.)

select year, make, model, (hwy+cty)/2 as average_mpg
from vehicles;

--Q9 Write a query that returns the year, make, model, 
--and a text field displaying “X highway; Y city.”
--(For example, if hwy is 24 and cty is 20, then hwy_city is “24 highway; 20 city.”)

select year, make, model, concat(hwy ||' '||'highway'||';'||' '||cty||' '||'city.') as "X highway; Y City."
from vehicles;

-- Q10 Write a query that returns the id, make, model,
-- and year for all records that have NULL for either the cyl or displ fields.

select id, make, model
from vehicles
where cyl IS NULL or displ IS NULL;

-- Q11 Write a query that returns all fields for records with rear-wheel drive 
-- and diesel vehicles since 2000, inclusive. 
-- Also sort by year and highway mileage, both descending.

--select distinct drive from vehicles; Rear-Wheel Drive
--select distinct fuel from vehicles;
select * from vehicles
where upper(drive) = upper('Rear-Wheel Drive')
and upper(fuel) = upper('Diesel')
and year >= 2000
order by year,hwy desc;

-- Q12 Write a query that counts the number of vehicles that are either 
--Fords or Chevrolets and either compact cars or 2-seaters. 
--Provide the query and the answer.
--select distinct make from vehicles; -- Ford; Chevrolet
--select distinct class from vehicles; -- Compact Cars, Two Seaters
select count(*),make,class
from vehicles
where class IN ('Compact Cars','Two Seaters')
and make IN ('Ford','Chevrolet')
group by make,class
order by make,class;

--Q13 Write a query that returns the records for 10 vehicles 
--with the highest highway fuel mileage.
select a.hwy,a.* from vehicles a
order by a.hwy desc
LIMIT 10;

-- Q14 Write a query that returns all the records of vehicles since the year 2000 
--whose model name starts with a capital X. Sort the list A through Z by make.
--What happens when you use a lowercase “x” instead? 
--select distinct model from vehicles;
select *
from vehicles
where year >= 2000
and INITCAP(model) LIKE 'X%'
order by model;
-- Query to pull all the models starting with lowercase x
select *
from vehicles
where year >= 2000
and model LIKE 'x%'
order by model;


--Q15 Write a query that returns the count of records where the “cyl” field is NULL. 
--Provide the query as well as the answer.
select count(*) from vehicles where cyl IS NULL;
-- Answer: 58

-- Q16 Write a query that returns the count of all records before the year 2000 
--that got more than 20 mpg hwy and had greater than 3 liters displacement (“displ” field). 
--Provide the query as well as the answer.
--select distinct displ from vehicles
select count(*) from vehicles
where year < 2000
and hwy > 20
and displ > 3;
-- Answer: 1964

-- Q17 Write a query that returns all records whose model name
--has a (capital) X in its 3rd position. Hint: make sure your 
--wildcard operator accommodates for any characters after the “X”! 

select *
from vehicles
where model like '__X%';