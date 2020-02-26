--Q1 Write a query that returns a list of all the unique values in the 'country' field.
select distinct country from ksprojects;

--Q2 How many unique values are there for the main_category field? What about for the category field?
select * from ksprojects;
select count(distinct main_category) AS MainCategory, count(distinct category) AS Category from ksprojects; -- 15; 158

-- Q3 Get a list of all the unique combinations of main_category and category fields, sorted A to Z by main_category.
select distinct main_category,category 
from ksprojects
order by main_category;

--Q4 How many unique categories are in each main_category? 
select main_category,count(distinct category)
from ksprojects
group by main_category;

-- Q5 Write a query that returns the average number of backers per main_category,
-- rounded to the nearest whole number and sorted from high to low.
select round(avg(backers),0) as average_backers,main_category
from ksprojects
group by main_category
order by average_backers desc;

--Q6 Write a query that shows, for each category, 
--how many campaigns were successful and the average difference 
--per project between dollars pledged and the goal.

select count(*),category,avg(usd_pledged - goal) as avergagepledged
from ksprojects
where state = 'successful'
group by category;

--Q7 Write a query that shows, for each main category, how many projects had zero backers for that category
--and the largest goal amount for that category (also for projects with zero backers).
select main_category, count(*) as Zero_Backers,max(goal)
from ksprojects
where backers = 0
group by main_category;

--Q8 For each category, find the average USD per backer, and return only those results for
--which the average USD per backer is < $50, sorted high to low. Hint: Division by NULL is not possible, 
--so use NULLIF to replace NULLs with 0 in the average calculation.

select category, avg(usd_pledged/NULLIF(backers,0)) as avg_usd
from ksprojects
group by category
having avg(usd_pledged/NULLIF(backers,0)) < 50
order by avg_usd desc;

-- Q9 Write a query that shows, for each main_category, how many successful projects had between 5 and 10 backers.
select distinct state from ksprojects;

select main_category, count(*)
from ksprojects
where state='successful'
and backers between 5 and 10
group by main_category;

--Q10 Get a total of the amount ‘pledged’ for each type of currency 
-- grouped by its respective currency. Sort by ‘pledged’ from high to low. 
select currency,sum(pledged) as total
from ksprojects
group by currency
order by total desc;

--Q11 Excluding Games and Technology records in the main_category field, return the total of 
--all backers for successful projects by main_category where the total was more than 100,000. 
--Sort by main_category from A to Z.

select main_category, sum(backers) as Total
from ksprojects
where main_category NOT IN ('Games','Technology')
and state = 'successful'
group by main_category
having sum(backers) > 100000
order by main_category;