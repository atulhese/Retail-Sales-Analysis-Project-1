-----------------start project ---------------------------

create database sql_project_p1;

create table retail_sales(
	transactions_id int primary key,
	sale_date date,
	sale_time time
	customer_id int,
	gender varchar(10),
	age int,
	category varchar(10),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float

);

-------------- Data Cleaning ---------------------------------
select * from retail_sales;


---------------------
select count(*) 
from retail_sales;

---------------------
select * from retail_sales
where
transaction_id is null
or
gender is null,
or
category is null
or
quantiy is null
or
cogs is null
or
total_sale is null;

---------------------------------------------
delete from retail sales 
where 
	transaction_id is null
	or
	gender is null,
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	total_sale is null;
---------------------------------------------------

---------- Data Exploration -----------------------------

------ 1) How many sales we have?

	salect count(*) as total_sales from retail_sales;

------ 2) how many unique customer we have?

	select count(distinct customer_id) from retail_sales;

-------3) How many unique category name we have?

	select unique category from retail_sales;

-------------------------------------------------------------------------

--------------Data Analysis ---------------------------------------

--1) Write a SQL query to retrive all columns for sales made on '2022-11-05'

	select * from retail_sales
	where sale_date = '2023-11-05';

--2) Write a sql query to retrive all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of nov-2022

	select category,
	sum(quantiy)
	from
	retail_sales
	where category = 'Clothing'
	group by 1;

-- 3)Write a sql query to calculate the total sales (total_sales) for each category

	select 
	category,
	sum(total_sale) as total_sales,
	count(*) as total_orders
	from retail_sales
	group by 1
	
-- 4) Write a sql query to find the average age of customers who purchased items from the 'Beauty' category

	select
	round(avg(age),2) as avg_age
	from retail_sales
	where category = 'Beauty';

-- 5) Write a sql query to find all transactions where the total_sale is greater than 1000

	select * from retail_sales
	where total_sale > 1000;


-- 6) Write a sql query to find the total number of transactions (transaction_id) made by each gender in each category

	select 
		category,
		gender,
		count(*) as total_items
		from retail_sales
		group by category, gender
		order by 1;


-- 7) Write a sql query to calculate average sale for each month, find out best selling month in each year

select
year,
month,
avg_sale
from
(
select
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over(partition by extract(year from sale_date)order by avg(total_sale)desc)as rank
from retail_sales
group by 1,2
)
as t1
where rank = 1;


-- 8) Write a sql query to find the top 5 customers based on the highest total sales

select customer_id,
	sum(total_sale) as total_sales 
	from retail_sales
	group by 1
	order by 2 desc
	limit 5;


-- 9) Write a sql query to find the number of unique customers who purchased items each category

select
	category,
	count(distinct customer_id) as count_unique  
	from retail_sales
	group by category;

-- 10) Write a sql query to create each shift and number of orders ( example morning <=12, afternoon between 12 & 17 , evening > 17)

with hourly_sales as (
select *,
	case 
		when extract(hour from sale_time)<12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retail_sales
)
select 
	shift,
	count(*) as total_orders
from hourly_sales
group by shift


--------------------------------end of project ---------------------------------





